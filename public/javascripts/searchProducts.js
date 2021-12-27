

$(document).ready(function() {
  // click search
    $("#searchBtn").on('click', (event)=>{
    let keyword = $("#shop-search").val();
    if(keyword === ''){
      $("#shop-search").prop('disabled',true);

    }
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
    // enter search ter
    $("#searchBtn").on("keyup", (event) => {
      if(event.keycode === 13) {
        let catOption = $("input[name=category]:checked", "#categoryForm");
        
        const value = catOption.val();
        let form = $("#searchForm");

        if ($("input[name=category]", "#searchForm").val() === undefined) {
          $("<input>")
            .attr({
              name: "category",
              value: value,
              display: "none",
            })
            .appendTo(form);
        } else {
          $("input[name=category]", "#searchForm").val(value);
        }
        form.submit();
      }
    });
  
    //filter category
    $("input[name=category]", "#categoryForm").on('click',(event)=>{
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