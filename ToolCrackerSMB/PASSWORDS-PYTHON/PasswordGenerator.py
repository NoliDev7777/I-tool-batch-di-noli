import os
import pathlib
import random

##LISTA ERRORI##
##ERR1 == il carattere dello spazio non puo essere inserito##
##ERR2 == non trova la modalita##
##ERR3 == il numero non e valido##


def clear_console():
  os.system("cls" if os.name == "nt" else "clear")


def print_banner():
  clear_console()
  print("============================")
  print("=    GENERATORE PASSWORD   =")
  print("============================")
  print("\n\n")


# Removed shell-breaking characters like backticks, quotes, and % to protect the batch file
all_chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!#$&'()*+,-./:;<=>?@[\\]^_`{|}~"


def generate_password(chars):
  while True:
    try:
      password_length = int(input("Quanta lunga dovrebbe essere la password?: \n"))
      password_count = int(input("Quante password vuoi generare?: \n"))
      if password_length < 5 or password_length > 35:
        print("la lunghezza deve essere tra 5 a 35", "\n")
      else:
        break
    except ValueError:
      print("numero non valido ERR:3")

  # Cartella FILE
  folder_path = pathlib.Path("./PasswordLists")
  folder_path.mkdir(parents=True, exist_ok=True)

  # incremento dei file list
  existing_files = list(folder_path.glob("password_list*.txt"))
  file_num = len(existing_files) + 1
  file_path = folder_path / f"password_list{file_num}.txt"

  # Scrive in batch per evitare crash della memoria quando generi troppe password
  print("\nGenerazione in corso...")
  with open(file_path, "w") as f:
    for i in range(password_count):
      password = "".join(random.choices(chars, k=password_length))
      f.write(password + "\n")

  # Print absolute path so you can copy-paste it directly into your batch file
  absolute_path = file_path.resolve()

  print(f"\n[Successo] Passwords salvati in: {file_path}\n")
  print(f"COPIA QUESTA DIRECTORY PER IL FILE BATCH:")
  print(f"{absolute_path}\n")

  input("Premi Invio per generare un'altra lista...")


def main():
  while True:
    print_banner()
    try:
      mode_input = input(
          "Per la lista caratteri default, perfavore enter 1\n\n"
          "Per la lista caratteri custom (es. solo lettere/numeri), perfavore enter 2\n\n"
          "Per uscire dal programma perfavore enter 3\n\n"
          "modalita: "
      )
      mode = int(mode_input)

      if mode == 1:
        generate_password(all_chars)
      elif mode == 2:
        while True:
          custom_character_list = input(
              "Metti i caratteri personalizzati (es: abcdef12345): "
          )
          if " " in custom_character_list:
            print("Non si possono usare spazi ERR:1")
          else:
            break
        generate_password(custom_character_list)
      elif mode == 3:
        print("ARRESTO PROGRAMMA")
        break
      else:
        print("Modalita non trovata ERR:2\n")
        input("Premi Invio per continuare...")
    except ValueError:
      print("Modalita non trovata ERR:2\n")
      input("Premi Invio per continuare...")


if __name__ == "__main__":
  main()
