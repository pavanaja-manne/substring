class AlgorithmsController < ApplicationController
  def bruteforce
    start_time = Time.now
    result = -1
    text = params[:text1].strip
    pattern = params[:text2].strip
    m = pattern.length
    n = text.length
    (0..(n-m)).each do |i|
      j = 0
      while(j < m && text[i+j] == pattern[j])
        j = j+1        
      end  
      if j == m
        result = i
        break
      end  
    end  
    end_time = Time.now
    output = {}
    output[:success] = true
    output[:result] = result
    output[:time] = end_time - start_time
    render :json => output.to_json
  end

  def morissprat
    start_time = Time.now
    result = -1
    text = params[:text2].strip
    pattern = params[:text1].strip
    n = pattern.length
    m = text.length
    mpNext = []
    puts text
    puts m
    puts pattern
    puts "patterm:#{n}"
    ## PreProcessing
    i = 0 
    j = mpNext[0] = -1
    while(i < m)
      while(j > -1 && text[i] != text[j])
          j = mpNext[j];
      end
      i = i+1
      j = j+1
      mpNext[i] = j
    end  
    
    #######################################
    ## Searching ##########################
    i=0
    j=0
    while(j<n)
      while(i > -1 && text[i] != pattern[j])
            i = mpNext[i]
          end  
          i = i+1
          j = j + 1
          if(i >= m)
              result = j -i
              i = mpNext[i] 
          end  
    end
    end_time = Time.now
    output = {}
    output[:success] = true
    output[:result] = result
    output[:time] = end_time - start_time
    render :json => output.to_json
  end

  ##################################
  ## Boyer Moore ######################
  ##################################
  def boyerMoore
    start_time = Time.now
    result = -1
    text  = params[:text1].strip
    pattern = params[:text2].strip
    text_len = text.size
    pattern_len = pattern.size
    return nil if text_len == 0
    return text if pattern_len == 0
    
    badcharacter = self.prepare_badcharacter_heuristic(pattern)
    goodsuffix   = self.prepare_goodsuffix_heuristic(pattern)
    ###############################
    ####### Search Logic
    s = 0
    while s <= text_len - pattern_len
      j = pattern_len
      while (j > 0) && self.needle_matches?(pattern[j-1], text[s+j-1])
        j -= 1
      end
      if(j > 0)
        k = badcharacter[text[s+j-1]]
        k = -1 unless k
        if (k < j) && (m = j-k-1) > goodsuffix[j]
          s += m
        else
          s += goodsuffix[j]
        end
      else
        puts s
        result =  s
        break
      end
    end
    puts s
    end_time = Time.now
    output = {}
    output[:success] = true
    output[:result] = result
    output[:time] = end_time - start_time
    render :json => output.to_json
  end  
    
 ###################################
 #### Shift OR #####################
 ######################
 def shiftor  
    start_time = Time.now
    result = -1
    text = params[:text2].strip
    pattern = params[:text1].strip
    n = pattern.length
    m = text.length
    s = {}
    ## PreProcessing
    (0..n).each do |i|
      s[i] = ~0
    end  
    lim = 0
    i = 0
    j = 1
    while(i<m)
      puts "preprocessing"
      puts text[i]
      puts j
      s[text[i]] &= ~j
      puts s[text[i]]
      puts s
      lim |= j
      i = i+1
      j <<= 1
    end  
    lim = ~(lim>>1)
    #######################################
    ## Searching ##########################
    state = ~0
    j = 0
    while(j<n)
      puts state
      puts s
      puts s[pattern[j]]
      state = (state<<1) | s[pattern[j]]
      if(state < lim)
        result = j-m+1
      end  
      j = j+1  
    end  
    end_time = Time.now
    output = {}
    output[:success] = true
    output[:result] = result
    output[:time] = end_time - start_time
    render :json => output.to_json
  end

  def knuthmorissprat
      start_time = Time.now
      result = -1
      text = params[:text2].strip
      pattern = params[:text1].strip
      n = pattern.length
      m = text.length
      kmpNext = []
      puts text
      puts m
      puts pattern
      puts "patterm:#{n}"
      ###########################
      ## PreProcessing
      i = 0 
      j = kmpNext[0] = -1
      while(i < m)
          while(j > -1 && text[i] != text[j])
              j = kmpNext[j]
          end
          i = i+1
          j = j+1
        if (text[i] == text[j])
          kmpNext[i] = kmpNext[j];
        else
          kmpNext[i]  = j
        end  
      end  
      #######################################
      ## Searching ##########################
      i=0
      j=0
      while(j<n)
          while(i > -1 && text[i] != pattern[j])
            i = kmpNext[i]
          end  
          i = i+1
          j = j + 1
          if(i >= m)
            result = j -i
            i = kmpNext[i] 
          end  
      end
    end_time = Time.now
    output = {}
    output[:success] = true
    output[:result] = result
    output[:time] = end_time - start_time
    render :json => output.to_json
  end
  
  def needle_matches?(needle, haystack)
    if needle.kind_of?(Regexp)
      needle.match(haystack) ? true : false 
    else
      needle == haystack
    end
  end
  
  def prepare_badcharacter_heuristic(str)
    result = RichHash.new
    0.upto(str.length - 1) do |i|
      result[str[i]] = i
    end
    result
  end

  def prepare_goodsuffix_heuristic(normal)
    size = normal.size
    result = []
    reversed = normal.dup.reverse
    prefix_normal = compute_prefix(normal)
    prefix_reversed = compute_prefix(reversed)
    0.upto(size) do |i|
      result[i] = size - prefix_normal[size-1]
    end
    0.upto(size-1) do |i|
      j = size - prefix_reversed[i]
      k = i - prefix_reversed[i]+1
      result[j] = k if result[j] > k
    end
    result
  end
  
  def compute_prefix(str) 
    size = str.length
    k = 0
    result = [0]
    1.upto(size - 1) do |q|
      while (k > 0) && (str[k] != str[q])
        k = result[k-1]
      end
      k += 1 if(str[k] == str[q])
      result[q] = k
    end
    result
  end
  
end

class RichHash
  def initialize
    @regexps = {}
    @regular = {}
  end

  def [](k)
    regular = @regular[k]
    return regular if regular
    if @regexps.size > 0
      @regexps.each do |regex,v| # linear search is going to be slow
        return v if regex.match(k) 
      end
    end
    nil
  end

  def []=(k,v)
    if k.kind_of?(Regexp)
      @regexps[k] = v
    else
      @regular[k] = v
    end
  end
end