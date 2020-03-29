$(function() {
    function buildChildHTML(child){
      var html =`<a class="child_category" id="${child.id}" 
                  href="/category/${child.id}">${child.name}</a>`;
      return html;
    }
   
    $("#catBtn").mouseover(function(){
      if($(".parents_list").css('display') == 'none'){
        $(".parents_list").show();
      }
    });

    // $(".category_list").mouseout(function(){
    //   $(".category_list").hide();
    // });

    // $('.categoriesss').hover(
    //   function() {
    //     $(this).append(html);
    //   },
    //   function() {
    //     $(this).find(".parent_category").remove();
    //   }
    // );
    


    $(".parent_category").on("mouseover", function() {
      var id = this.id
      $(".now-selected-green").removeClass("now-selected-green")
      $('#' + id).addClass("now-selected-green");
      $(".child_category").remove();
      $(".grand_child_category").remove();
      $.ajax({
        type: 'GET',
        url: '/categories/new',
        data: {parent_id: id},
        dataType: 'json'
      }).done(function(children) {
        children.forEach(function (child) {
          var html = buildChildHTML(child);
        
          $(".children_list").append(html);
        })
      });
    });
  
    
    function buildGrandChildHTML(child){
      var html =`<a class="grand_child_category" id="${child.id}"
                 href="/category/${child.id}">${child.name}</a>`;
      return html;
    }
  
    $(document).on("mouseover", ".child_category", function () {
      var id = this.id
      $(".now-selected-green2").removeClass("now-selected-green2");
      $('#' + id).addClass("now-selected-green2");
      $.ajax({
        type: 'GET',
        url: '/categories/new',
        data: {parent_id: id},
        dataType: 'json'
      }).done(function(children) {
        children.forEach(function (child) {
          var html = buildGrandChildHTML(child);
          $(".grand_children_list").append(html);
        })
        $(document).on("mouseover", ".child_category", function () {
          $(".grand_child_category").remove();
        });
      });
    });  

    $(document).on("mouseover", ".grand_child_category", function () {
      var id = this.id
      $(".now-selected-green3").removeClass("now-selected-green3");
      $('#' + id).addClass("now-selected-green3");
    });



    
  });
 