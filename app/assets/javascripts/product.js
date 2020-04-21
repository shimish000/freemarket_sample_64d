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

    
    // カテゴリのトップページの実装で後に使います！

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

  // 商品出品のカテゴリ

  function appendOption(category){
    var html = `<option value="${category.name}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div class='listing-select-wrapper__added' id= 'children_wrapper'>
                        <div class='listing-select-wrapper__box'>
                          <select class="listing-select-wrapper__box--select" id="child_category" name="product[category_id]">
                            <option value="---" data-category="---">---</option>
                            ${insertHTML}
                          <select>
                          <i class='fas fa-chevron-down listing-select-wrapper__box--arrow-down'></i>
                        </div>
                      </div>`;
    $('.listing-product-detail__category').append(childSelectHtml);
  }
  function appendGrandchidrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='listing-select-wrapper__added' id= 'grandchildren_wrapper'>
                              <div class='listing-select-wrapper__box'>
                                <select class="listing-select-wrapper__box--select" id="grandchild_category" name="product[category_id]">
                                  <option value="---" data-category="---">---</option>
                                  ${insertHTML}
                                </select>
                                <i class='fas fa-chevron-down listing-select-wrapper__box--arrow-down'></i>
                              </div>
                            </div>`;
    $('.listing-product-detail__category').append(grandchildSelectHtml);
  }

  $('#parent_category').on('change', function(){
    var parentCategory = document.getElementById('parent_category').value; 
    if (parentCategory != "---"){ 
      $.ajax({
        url: '/products/get_category_children',
        type: 'GET',
        data: { parent_name: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_wrapper').remove(); 
        $('#grandchildren_wrapper').remove();
        $('#size_wrapper').remove();
        $('#brand_wrapper').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_wrapper').remove(); 
      $('#grandchildren_wrapper').remove();
      $('#size_wrapper').remove();
      $('#brand_wrapper').remove();
    }
  });

  $('.listing-product-detail__category').on('change', '#child_category', function(){
    var childId = $('#child_category option:selected').data('category');
    if (childId != "---"){ 
      $.ajax({
        url: '/products/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchildren_wrapper').remove(); 
          $('#size_wrapper').remove();
          $('#brand_wrapper').remove();
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchidrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchildren_wrapper').remove(); 
      $('#size_wrapper').remove();
      $('#brand_wrapper').remove();
    }
  });

// 商品詳細の画像
  $(function() {
    $('img.childimage').mouseover(function(){
      var selectedSrc = $(this).attr('src').replace(/^(.+)_thumb(\.gif|\.jpg|\.png+)$/, "$1"+"$2");
      $('img.product-detail__top__item-image-main--photo').stop().fadeOut(50,
        function(){
          $('img.product-detail__top__item-image-main--photo').attr('src', selectedSrc);
          $('img.product-detail__top__item-image-main--photo').stop().fadeIn(200);
        }
      );
      $(this).css({"border":"1px solid #fff"});
    });
    $('img.childimage').mouseout(function(){
      $(this).css({"border":""});
    });
  });
});