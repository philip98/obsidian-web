module BooksHelper
	def book_lookup(isbn)
		if (a = current_school.aliases.find_by(:name => isbn))
			return a.book
		elsif (b = current_school.books.find_by(:isbn => isbn))
			return b
		else
			return nil
		end
	end
end
