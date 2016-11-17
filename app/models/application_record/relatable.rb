class ApplicationRecord
	module Relatable

		RELATABLE_MODEL_CLASSES_WITH_FOREIGN_KEYS = { FanIdol => [:fan_id, :idol_id], RivalVictim => [:rival_id, :victim_id] }

		module InstanceMethods

			def foreign_keys
				@foreign_keys ||= RELATABLE_MODEL_CLASSES_WITH_FOREIGN_KEYS[self.class]
			end

			def cannot_have_a_relationship_with_yourself
				errors.add(:base, "Cannot have a relationship with yourself") if self.send(foreign_keys[0]) == self.send(foreign_keys[1])
			end

			def a_couple_can_only_have_one_relationship_with_each_other
				RELATABLE_MODEL_CLASSES_WITH_FOREIGN_KEYS.each do |model_class, model_foreign_keys|
					if model_class.all.where(model_foreign_keys[0] => self.send(foreign_keys[0]), model_foreign_keys[1] => self.send(foreign_keys[1])).first
						errors.add(:base, "A couple can have only one relationship with each other")
						return
					end
				end
			end

		end
	end
end