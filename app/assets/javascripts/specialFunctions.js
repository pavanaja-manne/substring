// Brute Force
function calcBrutForce()
{
  text1 = $("#input-text1").val();
  text2 = $("#input-text2").val(); 
  if(text1==="" || text2===""){
    alert("Please Enter Both Input Text1 and Input Text2");    
    return false;
  }
  dataObj = {
    text1:text1,
    text2:text2    
  }
  $.ajax({
            url: "/bruteforce",
            data: dataObj,
            type: "POST",
              success: function(data) {
                if(data.success === true){
                  if(data.result != -1){
                      notification = "<a href='#' class='list-group-item' style='color:green'>Algorithm:Brute Force<br/>Found: <em>"+ data.time +" seconds</em></span></a>";
                      $("#list_group").prepend(notification);
                      new_text1 = text1.substring(0,data.result);
                      new_text2 = text1.substring(data.result+text2.length,text1.length);
                      $("#text_value").html(new_text1+"<span style='background-color:yellow'>"+ text2 +"</span>" + new_text2);
                      $("#pattern_value").html(text2);
                  }
                  else{
                      notification = "<a href='#' class='list-group-item' style='color:red'>Algorithm:Brute Force<br/>Not Found: <em>"+ data.time +" seconds</em></span></a>";
                      $("#list_group").prepend(notification);
                      $("#text_value").html(text1);
                      $("#pattern_value").html(text2);
                  }
                }
              },
              error: function() {
                 alert("unknown error occurred");
              }
  });
}



// Morris Pratt
function calcMorissPratt()
{
  text1 = $("#input-text1").val();
  text2 = $("#input-text2").val();
  if(text1=="" || text2==""){
    alert("Please Enter Both Input Text1 and Input Text2");    
    return false;
  }
  dataObj = {
    text1:text1,
    text2:text2    
  }
  $.ajax({
            url: "/morissprat",
            data: dataObj,
            type: "POST",
              success: function(data) {
                if(data.success === true){
                  if(data.result != -1){
                      notification = "<a href='#' class='list-group-item' style='color:green'>Algorithm:Moriss Pratt<br/>Found: <em>"+ data.time +" seconds</em></span></a>";
                      $("#list_group").prepend(notification);
                      new_text1 = text1.substring(0,data.result);
                      new_text2 = text1.substring(data.result+text2.length,text1.length);
                      $("#text_value").html(new_text1+"<span style='background-color:yellow'>"+ text2 +"</span>" + new_text2);
                      $("#pattern_value").html(text2);
                  }
                  else{
                      notification = "<a href='#' class='list-group-item' style='color:red'>Algorithm:Moriss Pratt<br/>Not Found: <em>"+ data.time +" seconds</em></span></a>";
                      $("#list_group").prepend(notification);
                      $("#text_value").html(text1);
                      $("#pattern_value").html(text2);
                  }
                }
              },
              error: function() {
                 alert("unknown error occurred");
              }
         });
   
  
}


// Boyer Moore Algorithm
function calcBoyerMoore()
{
  text1 = $("#input-text1").val();
  text2 = $("#input-text2").val();
  if(text1=="" || text2==""){
    alert("Please Enter Both Input Text1 and Input Text2");    
    return false;
  }
  dataObj = {
    text1:text1,
    text2:text2    
  }
  $.ajax({
            url: "/boyerMoore",
            data: dataObj,
            type: "POST",
              success: function(data) {
                if(data.success === true){
                  if(data.result != -1){
                      notification = "<a href='#' class='list-group-item' style='color:green'>Algorithm:Boyer Moore<br/>Found: <em>"+ data.time +" seconds</em></span></a>";
                      $("#list_group").prepend(notification);
                      new_text1 = text1.substring(0,data.result);
                      new_text2 = text1.substring(data.result+text2.length,text1.length);
                      $("#text_value").html(new_text1+"<span style='background-color:yellow'>"+ text2 +"</span>" + new_text2);
                      $("#pattern_value").html(text2); 
                  }
                  else{
                      notification = "<a href='#' class='list-group-item' style='color:red'>Algorithm:Boyer Moore<br/>Not Found: <em>"+ data.time +" seconds</em></span></a>";
                      $("#list_group").prepend(notification);

                      $("#text_value").html(text1);
                      $("#pattern_value").html(text2);
                  }
                }
              },
              error: function() {
                 alert("unknown error occurred");
              }
         }); 
}



/// Knuth Moriss algorithm
function calcKnuthMorissPratt()
{
  text1 = $("#input-text1").val();
  text2 = $("#input-text2").val();
  if(text1=="" || text2==""){
    alert("Please Enter Both Input Text1 and Input Text2");    
    return false;
  }
  dataObj = {
    text1:text1,
    text2:text2    
  }
  $.ajax({
            url: "/knuthmorissprat",
            data: dataObj,
            type: "POST",
              success: function(data) {
                if(data.success === true){
                  if(data.result != -1){
                      notification = "<a href='#' class='list-group-item' style='color:green'>Algorithm:Knuth Moriss Pratt<br/>Found: <em>"+ data.time +" seconds</em></span></a>";
                      $("#list_group").prepend(notification);
                      new_text1 = text1.substring(0,data.result);
                      new_text2 = text1.substring(data.result+text2.length,text1.length);
                      $("#text_value").html(new_text1+"<span style='background-color:yellow'>"+ text2 +"</span>" + new_text2);
                      $("#pattern_value").html(text2);
                  }
                  else{
                      notification = "<a href='#' class='list-group-item' style='color:red'>Algorithm:Knuth Moriss Pratt<br/>Not Found: <em>"+ data.time +" seconds</em></span></a>";
                      $("#list_group").prepend(notification);
                      
                      $("#text_value").html(text1);
                      $("#pattern_value").html(text2);
                  }
                }
              },
              error: function() {
                $('#cover').fadeOut(1000);
                 alert("unknown error occurred");
              }
         }); 
}

