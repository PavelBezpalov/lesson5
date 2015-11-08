class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ %r{
                  (?=[a-zA-Z0-9@.!#$%&'*+/=?^_`{|}~-]{6,254}\z)
                  (?=[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]{1,64}@)
                  [a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+
                  (?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*
                  @(?:(?=[a-zA-Z0-9-]{1,63}\.)
                  [a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+
                  (?=[a-zA-Z0-9-]{1,63}\z)[a-zA-Z0-9]
                  (?:[a-zA-Z0-9-]*[a-zA-Z0-9])?
                              }x
      record.errors[attribute] << (options[:message] || 'is not a valid email')
    end
  end
end