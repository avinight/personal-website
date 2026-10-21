---
tags:
  - computer-science
---
Tags:
Links: [[148-CSC148]]

---
# Object-Oriented Programming

A class need not be instantiated as a variable and can run with out error given the initializer's parameters are satisfied.

Example:
```Python
class HockeyTeam:  
    """A hockey team in a league  
  
 === Attributes === name: the name of this team games_played: number of games this team has played wins: the number of games this team has won """ name: str  
 games_played: int  
 wins: int  
  
 def __init__(self, name: str) -> None:  
        """Initialize this hockey team, with no games played yet.  
 """ # TODO: Record team name.  
        # TODO: Set number of games and wins to zero.  
  
 def record_result(self, result: str) -> None:  
        """Record a win/loss from a game.  
  
 Precondition: result == 'W' or result == 'L' """ # TODO: Update number of games played and number of wins,  
 # as appropriate.
team = HockeyTeam('Team 148')
HockeyTeam.record_result(team, 'W')
team.record_result('W')
```


<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
- https://en.wikipedia.org/wiki/Object-oriented_programming