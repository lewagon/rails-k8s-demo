module MessagesHelper
  def flex_position(message, &block)
    if message.author == Current.username
      content_tag(:div, capture(&block), class: "d-flex flex-row-reverse")
    else
      content_tag(:div, capture(&block), class: "d-flex flex-row")
    end
  end
end
