module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def json_response_with_meta(object, meta, status = :ok)
    render json: object, meta: meta, status: status, adapter: :json
  end

  def pagination_meta(object)
    {
        current_page: object.current_page,
        next_page: object.next_page,
        prev_page: object.previous_page,
        total_pages: object.total_pages,
        total_count: object.total_entries
    }
  end
end