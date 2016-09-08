module FieldsHelper
  def link_to_add_fields(name, form, association)
    new_object = form.object.send(association).klass.new
    id = new_object.object_id

    fields = form.simple_fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + '_fields', form: builder)
    end

    data = { id: id, fields: fields.delete("\n") }
    link_to(name, '#', class: 'add_fields', data: data)
  end
end
