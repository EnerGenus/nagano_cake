class SearchesController < ApplicationController

  def search
    @query = params[:query]
    @search_type = params[:search_type]  # 会員検索 or 商品検索
    @match_type = params[:match_type]    # 完全一致, 前方一致, 後方一致, 部分一致

    if @search_type == 'Customer'
      @results = Customer.search_by_fullname(@query, @match_type)
    elsif @search_type == 'Item'
      @results = Item.search_by_name(@query, @match_type)
    else
      @results = []  # どちらにも該当しない場合、@results は空の配列 [] になる
    end

    render 'searches/search_results'
  end
end
