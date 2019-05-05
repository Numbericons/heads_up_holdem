# heads_up_holdem
Basic Usage:
'ruby holdem.rb'

Will initialize 2 players with chipstacks and a new instance of the Board class. This allows a single 'hand' of poker to be played.
Play should continue until one of the players chipstack reaches 0.

Known issues:
Lacks error checking. 
Player input must be entered exactly. 
Players must not bet more than they have (needs to be checked). 
Preflop - bb 'option', when the small blind simply calls and the bb can choose to check or raise, incorrectly displays the word 'bet' instead of 'raise'

Thank you to the creator of the 'ruby-poker' gem, Robolson, which is utilized to check hand strengths against eachother.

Creator - Zachary Oliver
