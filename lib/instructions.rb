module Instructions
    def self.display_instructions
        instructions = """
        You are in a radio room in a dark room in the Pentagon's east wing, 
        communicating remotely with two battleships that have just sighted
        a pair of enemy vessels. Your mission is to relay firing directions to the men
        on deck. 
        
        First, you will order our battleships to assume an approximate location on the water,
        represented by a 4x4 grid of tiles. Our submarines have narrowed the enemy location down
        to a stretch of water of similar dimensions. 

        After our ships have taken position, you will radio shot coordinates to the battleship commander.

        There are no reinforcements. This fight is to the death.  

        Good luck, general. The souls of these men rest in your hands.
        """
        puts instructions
    end 
end