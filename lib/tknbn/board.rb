require 'ncursesw'
class Board
	attr_reader :width, :height

	def initialize(width: 80, height: 24)
		@width = width
		@height = height
		@is_running = true

		Ncurses.initscr
		Ncurses.start_color
		Ncurses.cbreak
		Ncurses.noecho

		background = Ncurses::COLOR_BLACK

		@screen = Ncurses.stdscr
		Ncurses.refresh
	end

	def display
		@screen.refresh
	end

	def run
		@screen.clear
		@screen.mvaddstr(0, 0, "Hello\n")
		@screen.mvaddstr(1, 0, "To display shit, hit 'd', to exit hit 'q'.\n")
		while @is_running
			display
			choice = Ncurses.stdscr.getch
			self.tick(choice)
		end
	end

	def tick(choice)
		if choice == "q".ord
			@is_running = false
			Ncurses.endwin()
		elsif choice == "d".ord
			self.display_shit
		end
	end

	def display_shit
		Project.all.each.with_index do |pr, idx|
			disp = "#{idx + 1}. #{pr.name}"
			@screen.mvaddstr(2+idx, 0, disp)
		end
		@screen.refresh
	end


end
