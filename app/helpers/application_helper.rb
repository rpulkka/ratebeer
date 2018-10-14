module ApplicationHelper
  def edit_and_destroy_buttons(item)
    unless current_user.nil?
      edit = link_to('Edit', url_for([:edit, item]), class: "btn btn-primary")
      if current_user.admin == true
        del = link_to('Destroy', item, method: :delete,
                                    data: { confirm: 'Are you sure?' },
                                    class: "btn btn-danger")
      end
      raw("#{edit} #{del}")
    end
  end

  def round(number)
    if(number == nil)

      return 0
    end
    number_with_precision(number, precision: 1)
  end
end
