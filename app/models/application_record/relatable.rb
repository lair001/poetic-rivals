class ApplicationRecord
	module Relatable

		RELATABLE_MODEL_CLASSES_WITH_FOREIGN_KEYS = [[FanIdol, :fan_id, :idol_id], [RivalVictim, :rival_id, :victim_id]]

		module InstanceMethods

			def relationship(first_foreign_key, second_foreign_key)
				first_foreign_key_value = self.send(first_foreign_key)
				second_foreign_key_value = self.send(second_foreign_key)
				if first_foreign_key_value == second_foreign_key_value
					errors.add(:base, "Cannot have a relationship with yourself")
					return
				end
				RELATABLE_MODEL_CLASSES_WITH_FOREIGN_KEYS.each do |model_class_with_foreign_keys|
					if model_class_with_foreign_keys[0].all.where(model_class_with_foreign_keys[1] => first_foreign_key_value, model_class_with_foreign_keys[2] => second_foreign_key_value).first
						errors.add(:base, "A couple can have only one relationship")
						return
					end
				end
			end

		end
	end
end