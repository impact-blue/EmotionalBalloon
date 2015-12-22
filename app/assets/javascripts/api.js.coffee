
  // paginationからajax:successが発火したら処理を開始
  $('#paginator').on 'ajax:success',  (e, result, status, xhr) ->

    // controllerでresultの中に入れたpaginatorとbooksをそれぞれ表示する
    $('#paginator').html result.paginator
    $('#books').html result.books

  // 読み込みした後にajaxでサーバへリクエストを投げる
  $.ajax(
    url: "/books_ajax",  // ajaxアクションを明示
    success: (data, status, xhr) ->  // ajaxの処理が成功した場合
    if data.success
      $("paginator").trigger('ajax:success', [ data, status, xhr])  // "#paginator"の中で"ajax:success"を発火させる
    end
  )