# Movie App (MVC + SQLite)

App de exemplo para a disciplina *Programação para Dispositivos Móveis* (2025.2).
Arquitetura: **MVC**
DB: **SQLite**
Grupo: **axl e igor**

### Como rodar
1. Tenha o Flutter instalado.
2. No terminal, execute:
   ```bash
   flutter pub get
   flutter run
   ```

### Funcionalidades implementadas
- Listar filmes (Image.network, RatingBar)
- CRUD com SQLite (sqflite)
- Cadastrar / Editar / Deletar (Dismissible swipe)
- Tela de detalhes
- Validações de formulário
- Menu ao tocar no item (Exibir / Alterar)
- AlertDialog no AppBar com o nome do grupo

Os arquivos principais estão em `lib/` na estrutura MVC: `models`, `views`, `controllers`, `services`, `widgets`.
