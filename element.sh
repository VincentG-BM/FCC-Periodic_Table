#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

SYMBOL=$1

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else

  # if input is not a number
  if [[ ! $SYMBOL =~ ^[0-9]+$ ]]
  then
    # if input is greater than 2 letters
    LENGTH=$(echo -n "$SYMBOL" | wc -m)
    if [[ $LENGTH -gt 2 ]]
    then

      # then use full name
      DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$SYMBOL'")
      if [[ -z $DATA ]]
      then
        echo I could not find that element in the database.
      else
        echo $DATA | while read BAR BAR NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOILING BAR TYPE
        do
          echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
        done
      fi

    else
      # else use symbol
      DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$SYMBOL'")
      if [[ -z $DATA ]]
      then
        echo I could not find that element in the database.
      else
        echo $DATA | while read BAR BAR NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOILING BAR TYPE
        do
          echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
        done
      fi

    fi

  else

      # use atomic number
    DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number='$SYMBOL'")
      if [[ -z $DATA ]]
      then
        echo I could not find that element in the database.
      else
        echo $DATA | while read BAR BAR NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOILING BAR TYPE
        do
          echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
        done
      fi

  fi
fi
