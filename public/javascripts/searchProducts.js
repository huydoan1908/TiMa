
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
});