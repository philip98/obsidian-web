module StudentsHelper
	def form_to_grad(form)
		if Time.current.mon >= 9
			13 + Time.current.year - form
		else
			12 + Time.current.year - form
		end
	end

	def grad_to_form(grad)
		if Time.current.mon >= 9
			13 + Time.current.year - grad
		else
			12 + Time.current.year - grad
		end
	end

	def display_class(data)
		"#{grad_to_form(data.graduation_year)}#{data.class_letter}"
	end
end
