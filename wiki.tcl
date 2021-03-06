#========================================================================
# ** Wikipedia Quick Link
#========================================================================
# * Description:
#
#    * Allows IRC users to link to wikipedia quickly through the bot.
#    * The default format is:
#       !wiki article name
#
#------------------------------------------------------------------------
# * Features:
#
#    * Replaces spaces by underscores. Example:
#         Article Name
#      will become
#         Article_Name
#      in the link
#    * Changes first letter of the article to upper case. Example:
#         article
#      will become
#         Article
#      in the link
#    * Mentions which nickname requested the link to prevent confusion.
#
#========================================================================

# Calls the script when people say !wiki at the start of the line.
# Changes this to whatever you want to make the script call on other
#  keywords.
bind pub - "!wiki" spidey:wiki_link

# Two letter language of the wiki you want to link to.
set wiki_lang "id"

proc spidey:wiki_link { nick host hand chan text } {

	# Turn spaces into underscores
	set article [string map {" " _} $text]
	# Make sure article name starts with upper case letter
	set article [string toupper [string index $article 0]][string range $article 1 end]

	# If no article is entered...
	if { $article == "" } {
		# Make it the main page article
		set article "Main_Page"
	}
	# Print link
	putserv "PRIVMSG $chan :\00312\037http://$::wiki_lang.wikipedia.org/wiki/$article\037\003 (Requested by \002$nick\002)"
}

# Log the script as successfully loaded.
putlog "Wikipedia Quick Link 1.1 by Hen Asraf: Loaded"