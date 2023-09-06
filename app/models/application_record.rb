class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  private
  def validate_presence_and_format(attribute)
    value = self[attribute]
    if value.blank?
      errors.add(attribute, "non può essere vuoto")
    elsif value !~ /\A[a-zA-Z_',.èàòì\d ]*\z/i
      errors.add(attribute, "non può contenere caratteri speciali")
    end
  end
end
