module BooksHelper
	def book_lookup(isbn)
		if !isbn || isbn.blank?
			return nil
		elsif (a = current_school.aliases.find_by(:name => isbn))
			return a.book
		elsif (b = current_school.books.find_by(:isbn => isbn))
			return b
		else
			return nil
		end
	end

	def display_title(book)
		u = current_school.usages.find_by(:book => book)
		if u and book
			"#{book.title} #{u.form}"
		else
			""
		end
	end
end
