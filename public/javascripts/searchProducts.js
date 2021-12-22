

$(document).ready(function() {
    $("#searchBtn").on('click', ()=>{
    let catOption = $("input[name=category]:checked", "#categoryForm");

    console.log(catOption.val());
    const value = catOption.val();
    let form = $("#searchForm");

    

    if ($("input[name=category]", "#searchForm").val() === undefined) {
        $("<input>")
          .attr({
            name: "category",
            value: value,
          })
          .appendTo(form);
    }
    else{
        $("input[name=category]", "#searchForm").val(value);
    }
    form.submit();
    })

     $("input[name=category]", "#categoryForm").on('click',(event)=>{
      //  window.location = "?category={{id}}";
    let url = window.location.href;
    let value = event.target.value;
    if(value != 0){
        window.location.assign(
          `/product?category=${value}`
        );
    }
    else{
      window.location.assign(`/product`);
    }
    })
});