class TargetingIdeaServiceValidator < ActiveModel::Validator
  def validate(object)
    object.errors.add(:keywords, "can't be blank") if object.keywords.all?(&:blank?)
    object.errors.add(:locations, "can't be blank") if object.locations.all?(&:blank?)
  end
end
