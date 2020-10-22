// flutter clean
// flutter run --release -d chrome
import 'package:app_projeto/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projeto Prático',
      theme: ThemeData(
        // Estilo de cores
        brightness: Brightness.light,
        primaryColor: Colors.yellow[600],
        accentColor: Colors.red[800],

        // Fonte padrão
        fontFamily: 'OpenSans',

        // Estilos de fonte
        textTheme: TextTheme(
          headline2: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
          headline3: TextStyle(fontSize: 25, color: Colors.grey),
          headline4: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          headline5: TextStyle(fontSize: 15, color: Colors.grey, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 15, color: Colors.grey[800]),
        ),
      ),

      // Navegação
      initialRoute: '/telalogin',
      routes: {
        '/telalogin': (context) => TelaLogin(),
        '/telaprincipal': (context) => TelaPrincipal(),
        '/telacadastro': (context) => TelaCadastro(),
        '/telasobre': (context) => TelaSobre(),
        '/telafilmes': (context) => TelaNavegarFilmes(),
        '/telajogos': (context) => TelaNavegarJogos(),
        '/telalivros': (context) => TelaNavegarLivros(),
        '/telamusicas': (context) => TelaNavegarMusicas(),
        //'/telaconfig': (context) => TelaConfigurarConta(),
      },
    )
  );
}



//
//----------------- TELA DE LOGIN
//
class TelaLogin extends StatefulWidget{
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin>{
  // Declara chave que identifica unicamente o formulário
  var formKey = GlobalKey<FormState>();

  // Atributos que recebem os valores de entrada (não utilizados por enquanto...)
  var txtNomeUsuario = TextEditingController();
  var txtSenha = TextEditingController();
  var txtEmail = TextEditingController();

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      
      body: Container(
        padding: EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              // 'formulario' de login
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Logotipo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.asset('assets/images/logo.jpg', scale: 5.0, fit: BoxFit.fitWidth,),
                  ),

                  SizedBox(height: 20),

                  // Título
                  Text(
                    'Entre na sua conta',
                    style: Theme.of(context).textTheme.headline2,
                  ),

                  SizedBox(height: 45),

                  // Input - TextFormField
                  campoTexto('Nome de Usuário', txtNomeUsuario, Icons.account_circle, false),
                  campoTexto('Senha', txtSenha, Icons.lock_rounded, true),
                  
                  SizedBox(height: 15),

                  // Esqueci a senha 'link'
                  Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                        text: 'Esqueci minha senha',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                        ..onTap = (){
                          caixaEntrada('Digite seu e-mail'); // 'input box'
                        }
                      ),
                    ),
                  ),

                  SizedBox(height: 60),

                  Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/telaprincipal');
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [Colors.yellow[700], Colors.yellow[400]],
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0)
                        ),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Entrar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
              ),

              SizedBox(height: 30),

              // 'link' para realizar cadastro
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Não possui uma conta? Cadastre-se aqui',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()

                    // Navegue para tela de cadastro
                    ..onTap = (){ 
                      Navigator.pushNamed(context, '/telacadastro');
                    }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //--CUSTOM WIDGET
  Widget campoTexto(rotulo, controle, icone, oculto){
    
    return ListTile(
      leading: Icon(icone, color: Colors.grey[800]),
      title: TextFormField(
        obscureText: oculto,
        controller: controle,
        cursorColor: Theme.of(context).primaryColor,        
        decoration: InputDecoration(
          hintText: rotulo,
          contentPadding: EdgeInsets.only(left: 5)
        ), 

        //Validação do valor fornecedido
        validator: (value){
        return (value.isEmpty) ? "Informe o valor" : null;
        },
      ),
    );
  }

  caixaEntrada(msg){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Recuperação de senha', style:TextStyle(fontSize: 12)),
          content: Container(
            height: 120,
            child: ListView(
              children: [
                Text('Uma mensagem será enviada em seu e-mail para redefinir sua senha.', style:TextStyle(fontSize: 15)),
                SizedBox(height: 10),
                campoTexto('E-mail', txtEmail, Icons.email_rounded, false)
              ]
            ),
          ),
          actions: [
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: Text('Enviar', style:TextStyle(fontSize: 15)),
            )
          ],
        );
      }
    );
  }
} // TelaLogin





//
//----------------- TELA DE CADASTRO
//
class TelaCadastro extends StatefulWidget{
  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro>{

  // Declara chave que identifica unicamente o formulário
  var formKey = GlobalKey<FormState>();

  // Atributos para armazenar valores de entrada (não utilizados por enquanto...)
  var txtNomeReal = TextEditingController();
  var txtNomeUsuario = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  var txtConfirmarSenha = TextEditingController();

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      
      // AppBar
      /*appBar: AppBar(      
        title: Text('Cadastro'),
        centerTitle: true,      
        actions: [],      
      ),*/

      body: Container(
        padding: EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              // 'formulario' de login
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Título
                  Text(
                  'Crie sua conta',
                  style: Theme.of(context).textTheme.headline2,
                  ),

                  SizedBox(height: 45),

                  // Input - TextFormField
                  campoTexto('Seu nome', txtNomeReal, Icons.account_circle, false),
                  campoTexto('Nome de Usuário', txtNomeUsuario, Icons.login_rounded, false),
                  campoTexto('E-mail', txtEmail, Icons.email_rounded, false),
                  campoTexto('Senha', txtSenha, Icons.lock_rounded, true),
                  campoTexto('Confirme sua senha', txtConfirmarSenha, Icons.verified_user_rounded, true),
                  
                  SizedBox(height: 60),

                  Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/telaprincipal');
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [Colors.yellow[700], Colors.yellow[400]],
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0)
                        ),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Cadastrar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
              ),
              
              SizedBox(height: 30),

              // 'link' realizar cadastro
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Já possui uma conta? Entre aqui',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                    ..onTap = (){
                      Navigator.pushNamed(context, '/telalogin');
                    }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  //--CUSTOM WIDGET
  Widget campoTexto(rotulo, controle, icone, oculto){

    return ListTile(
      leading: Icon(icone, color: Colors.grey[800]),
      title: TextFormField(
        obscureText: oculto,
        controller: controle,
        cursorColor: Theme.of(context).primaryColor,        
        decoration: InputDecoration(
          hintText: rotulo,
          contentPadding: EdgeInsets.only(left: 5)
        ), 
      ),
    );
  }
} // TelaCadastro





//
//----------------- TELA PRINCIPAL
//
class TelaPrincipal extends StatefulWidget{
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal>{

  // Scaffold Key
  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context){
    return MaterialApp(
    
      // Body com tab bar
      home: new DefaultTabController(
        
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'FILMES', icon: Icon(Icons.movie_creation_outlined)),
                Tab(text: 'JOGOS', icon: Icon(Icons.gamepad_rounded)),
                Tab(text: 'LIVROS', icon: Icon(Icons.book_rounded)),
                Tab(text: 'MÚSICAS', icon: Icon(Icons.music_note_rounded)),
              ],
            ),
            title: Text('Categorias'),
            backgroundColor: Theme.of(context).accentColor,
            
          ),
          body: TabBarView(
            children: [
              //CategoriaFilmeGeral();
              TelaNavegarFilmes(),

              //CategoriaJogoGeral();
              TelaNavegarJogos(),

              //LivroGeral();
              TelaNavegarLivros(),

              //MusicaGeral();
              TelaNavegarMusicas(),
            ],
          ),

          drawer: new Drawer(
            child: ListView(
              padding: EdgeInsets.zero, //----Removendo qualquer espaçamento da listView
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    children: [
                      Icon(Icons.account_circle, size: 80,),
                      Text('nome_do_usuario', style: TextStyle(fontSize: 25)),
                      Text('email@example.com', style: TextStyle(fontSize: 15)),
                    ]
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.movie_creation_outlined),
                  title: Text('Filmes'),
                  onTap: () {
                    caixaDialogo('Está funcionalidade ainda será desenvolvida...', 'Trabalho em progresso');
                    //TelaNavegarFilmes();
                    //Navigator.pushNamed(context, '/telafilmes');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.gamepad_rounded),
                  title: Text('Jogos'),
                  onTap: () {
                    caixaDialogo('Está funcionalidade ainda será desenvolvida...', 'Trabalho em progresso');
                    //TelaNavegarJogos();
                    //Navigator.pushNamed(context, '/telajogos');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.book_rounded),
                  title: Text('Livros'),
                  onTap: () {
                    caixaDialogo('Está funcionalidade ainda será desenvolvida...', 'Trabalho em progresso');
                    //TelaNavegarLivros();
                    //Navigator.pushNamed(context, '/telalivros');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.music_note_rounded),
                  title: Text('Músicas'),
                  onTap: () {
                    caixaDialogo('Está funcionalidade ainda será desenvolvida...', 'Trabalho em progresso');
                    //TelaNavegarMusicas();
                    //Navigator.pushNamed(context, '/telamusicas');
                  },
                ),
                ////////----- Esta funcionalidade ainda será desenvolvida....
                ListTile(
                  leading: Icon(Icons.help_outline_rounded),
                  title: Text('Ajuda'),
                  onTap: () {
                    caixaDialogo('Está funcionalidade ainda será desenvolvida...', 'Trabalho em progresso');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info_outline_rounded),
                  title: Text('Sobre o Projeto'), // Mostra as informações do tema do projeto
                  onTap: () {
                    Navigator.pushNamed(context, '/telasobre');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings_rounded),
                  title: Text('Configurações da conta'),
                  onTap: () {
                    caixaDialogo('Está funcionalidade ainda será desenvolvida...', 'Trabalho em progresso');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app_rounded),
                  title: Text('Sair'),
                  onTap: () {
                    // Voltar para de tela de login ou cadastro:
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
      
        ),
      ),
    );
  }

  //--CUSTOM WIDGET
  caixaDialogo(msg, titulo){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(titulo, style:TextStyle(fontSize: 14)),
          content: Text(msg, style:TextStyle(fontSize: 18)),
          actions: [
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: Text('OK')
            )
          ],
        );
      }
    );
  }
} // TelaPrincipal





//
//----------------- INFORMAÇÕES DO PROJETO (requisito)
//
class TelaSobre extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Informações do Projeto', style: TextStyle(fontSize: 24))),

      body: Container(
        padding: EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Aluno
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Diego Gabriel da Costa',
                        style: Theme.of(context).textTheme.headline3,
                        //textAlign: TextAlign.right
                      ),
                      Text(
                        'desenvolvedor',
                        style: Theme.of(context).textTheme.headline5,
                        //textAlign: TextAlign.right
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.asset('assets/images/dev.jpg', scale: 2.0, fit: BoxFit.fitWidth,),
                  ),
                ]
              ),

              SizedBox(height: 40),

              // Título
              Text(
                'Projeto Prático em Flutter SDK',
                style: Theme.of(context).textTheme.headline2,
              ),

              SizedBox(height: 5),

              // Descrição do Projeto
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText2,
                  children: <TextSpan>[
                    TextSpan(text: 'Este é um projeto prático da matéria de '),
                    TextSpan(text: 'Programação Para Dispositivos Móveis', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' da '),
                    TextSpan(text: 'Fatec Ribeirão Preto.', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '\nO tema escolhido é um aplicativo para vendas de produtos de entretenimento (livros, músicas, filmes e jogos).'),
                    TextSpan(text: '\nO objetivo do app é que o usuário possa \'comprar\' os produtos da '),
                    TextSpan(text: 'loja fictícia', style:(TextStyle(fontStyle: FontStyle.italic))),
                    TextSpan(text: ' Livros & Discos.', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' Cada categoria são subdivididas em \'gêneros\'. Por enquanto, foram utilizados dados estáticos somente para demonstração.'),
                  ]
                ),
              ),
            ]
          )
        )
      )
    );
  }
}





//
//----------------- TELAS PARA TABBAR
//

//
//----------------- FILMES
//
class TelaNavegarFilmes extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      //no appBar

      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [

            //--AÇÃO E AVENTURA
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Ação e Aventura', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarFilme('Jumanji: A Próxima Fase', 'Jake Kasdan', 2019, 'R\$ 40,50', 'assets/images/filmes/acao_e_aventura/capa_jake_kasdan_2019_jumanji_proxima_fase.jpg'),
                  MostrarFilme('Capitão América: O Soldado Invernal', 'Joe Russo e Anthony Russo', 2014, 'R\$ 34,50', 'assets/images/filmes/acao_e_aventura/capa_joe_and_anthony_russo_2014_capitao_america_soldado_invernal.jpg'),
                  MostrarFilme('Alita Anjo de Combate', 'Robert Rodriguez', 2019, 'R\$ 53,50', 'assets/images/filmes/acao_e_aventura/capa_robert_rodriguez_2019_alita_anjo_de_combate.jpg'),
                  MostrarFilme('As Aventuras de Tim Tim', 'Steven Spielberg', 2011, 'R\$ 26,50', 'assets/images/filmes/acao_e_aventura/capa_steven_spielberg_2011_as_aventuras_de_timtim.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--ANIMAÇÃO
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Animação', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarFilme('Mortal Kombat: A Vingança de Scorpion', 'Ethan Spaulding', 2020, 'R\$ 50,50', 'assets/images/filmes/animacao/capa_ethan_spaulding_2020_mortal_kombat_a_vingança_de_scorpion.jpg'),
                  MostrarFilme('Coraline e o Mundo Secreto', 'Henry Selick', 2009, 'R\$ 35,50', 'assets/images/filmes/animacao/capa_henry_selick_2009_coraline.jpg'),
                  MostrarFilme('Alita Anjo de Combate', 'Robert Rodriguez', 2019, 'R\$ 53,50', 'assets/images/filmes/animacao/capa_robert_rodriguez_2019_alita_anjo_de_combate.jpg'),
                  MostrarFilme('As Aventuras de Tim Tim', 'Steven Spielberg', 2011, 'R\$ 26,50', 'assets/images/filmes/animacao/capa_steven_spielberg_2011_as_aventuras_de_timtim.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--COMÉDIA
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Comédia', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarFilme('O Máskara', 'Chuck Russel', 1994, 'R\$ 19,50', 'assets/images/filmes/comedia/capa_chuck_russel_1994_o_maskara.jpg'),
                  MostrarFilme('Gente Grande 2', 'Dennis Dugan', 2010, 'R\$ 23,50', 'assets/images/filmes/comedia/capa_dennis_dugan_2010_gente_grande.jpg'),
                  MostrarFilme('As Branquelas', 'Keenen Wayans', 2004, 'R\$ 24,50', 'assets/images/filmes/comedia/capa_keenen_wayans_2004_as_branquelas.jpg'),
                  MostrarFilme('Debi & Lóide', 'Peter Farrelly', 2011, 'R\$ 26,50', 'assets/images/filmes/comedia/capa_peter_farrelly_1995_debi_e_loide.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--DOCUMENTÁRIOS
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Documentários', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarFilme('Amy', 'Asif Kapadi', 2015, 'R\$ 34,50', 'assets/images/filmes/documentario/capa_asif_kapadia_2015_amy.jpg'),
                  MostrarFilme('Ford Vs Ferrari', 'James Mangold', 2019, 'R\$ 23,50', 'assets/images/filmes/documentario/capa_james_mangold_2019_ford_v_ferrari.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--DRAMA
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Drama', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarFilme('O Podereso Chefão', 'Francis Coppola', 1972, 'R\$ 70,50', 'assets/images/filmes/drama/capa_francis_coppola_1972_o_poderoso_chefao.jpg'),
                  MostrarFilme('Titanic', 'James Cameron', 1997, 'R\$ 64,50', 'assets/images/filmes/drama/capa_james_cameron_1997_titanic.jpg'),
                  MostrarFilme('O Destino de Uma Nação', 'Joe Wright', 2018, 'R\$ 34,50', 'assets/images/filmes/drama/capa_joe_wright_2018_o_destino_de_uma_nação.jpg'),
                  MostrarFilme('O Farol', 'Robert Eggers', 2020, 'R\$ 23,50', 'assets/images/filmes/drama/capa_robert_eggers_2020_o_farol.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--FANTASIA
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Fantasia', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarFilme('Warcraft O Primeiro Encontro de Dois Mundos', 'Francis Coppola', 2016, 'R\$ 56,50', 'assets/images/filmes/fantasia/capa_duncan_jones_2016_warcraft.jpg'),
                  MostrarFilme('O Hobbit A Desolação de Smaug', 'Peter Jackson', 2013, 'R\$ 51,50', 'assets/images/filmes/fantasia/capa_peter_jackson_2013_o_hobbit_a_desolação_de_smaug.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--FICÇÃO
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Ficção', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarFilme('Interstellar', 'Christopher Nolan', 2014, 'R\$ 46,50', 'assets/images/filmes/ficcao/capa_christopher_nolan_2014_interstellar.jpg'),
                  MostrarFilme('Matrix', 'Lana Wachowski', 1999, 'R\$ 37,50', 'assets/images/filmes/ficcao/capa_lana_wachowski_1999_matrix.jpg'),
                  MostrarFilme('Ela', 'Spike Jonze', 2014, 'R\$ 63,50', 'assets/images/filmes/ficcao/capa_spike_jonze_2014_ela.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--ROMANCE
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Romance', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarFilme('Titanic', 'James Cameron', 1997, 'R\$ 46,50', 'assets/images/filmes/romance/capa_james_cameron_1997_titanic.jpg'),
                  MostrarFilme('Ela', 'Spike Jonze', 2014, 'R\$ 63,50', 'assets/images/filmes/romance/capa_spike_jonze_2014_ela.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--SERIADOS_TV
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Séries & TV', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarFilme('American Horror Story Segunda Temporada', 'Bradley Buecker', 2012, 'R\$ 52,50', 'assets/images/filmes/seriados_tv/capa_bradley_buecker_2012_american_horror_story_2_temporada.jpg'),
                  MostrarFilme('Gotham Quinta e Última Temporada', 'Bruno Heller', 2014, 'R\$ 47,50', 'assets/images/filmes/seriados_tv/capa_bruno_heller_2020_gotham_5_temporada.jpg'),
                  MostrarFilme('The Walking Dead Primeira Temporada', 'Frank Darabont', 2010, 'R\$ 35,50', 'assets/images/filmes/seriados_tv/capa_frank_darabont_2010_the_walking_dead_1_temporada.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--TERROR
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Terror', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarFilme('IT', 'Andy Mushietti', 2017, 'R\$ 54,50', 'assets/images/filmes/terror/capa_andy_muschietti_2017_it.jpg'),
                  MostrarFilme('IT: Capítulo 2', 'Andy Mushietti', 2019, 'R\$ 70,50', 'assets/images/filmes/terror/capa_andy_muschietti_2019_it_capitulo_2.jpg'),
                  MostrarFilme('A freira', 'Corin Hardy', 2018, 'R\$ 48,50', 'assets/images/filmes/terror/capa_corin_hardy_2018_a_freira.jpg'),
                  MostrarFilme('Sexta-Feira 13', 'Sean Cunningham', 1980, 'R\$ 47,50', 'assets/images/filmes/terror/capa_sean_cunningham_1980_sexta_feira_13.jpg'),
                  MostrarFilme('O Exorcista', 'William Blatty', 1971, 'R\$ 35,50', 'assets/images/filmes/terror/capa_william_blatty_1971_o_exorcista.jpg'),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}

//
//----------------- JOGOS
//
class TelaNavegarJogos extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      //no appBar

      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [

            //--AÇÃO E AVENTURA
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Ação e Aventura', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarJogo('Grand Theft Auto V', 'Multiplataforma', 2013, 'R\$ 35,50', 'assets/images/jogos/acao_e_aventura/capa_multi_2013_gta_v.jpg'),
                  MostrarJogo('Zelda: Breath Of The Wild', 'Nintendo Switch', 2017, 'R\$ 90,50', 'assets/images/jogos/acao_e_aventura/capa_nintendo_switch_2017_zelda_breath_of_the_wild.jpg'),
                  MostrarJogo('God Of War', 'PlayStation 4', 2018, 'R\$ 51,50', 'assets/images/jogos/acao_e_aventura/capa_ps4_2018_god_of_war_4.jpg'),
                  MostrarJogo('The Last Of Us Part II', 'PlayStation 4', 2013, 'R\$ 127,50', 'assets/images/jogos/acao_e_aventura/capa_ps4_2020_the_last_of_us_part_ii.jpg'),
                  MostrarJogo('Fallout 3', 'Xbox 360', 2008, 'R\$ 23,50', 'assets/images/jogos/acao_e_aventura/capa_xbox_360_2008_fallout_3.jpg'),
                  MostrarJogo('Fallout 4', 'Xbox One', 2015, 'R\$ 49,50', 'assets/images/jogos/acao_e_aventura/capa_xbox_one_2015_fallout_4.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--CORRIDA
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Corrida', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarJogo('Gran Turismo 6', 'PlayStation 3', 2013, 'R\$ 35,50', 'assets/images/jogos/corrida/capa_ps3_2013_gran_turismo_6.jpg'),
                  MostrarJogo('Forza 7', 'Xbox One', 2017, 'R\$ 90,50', 'assets/images/jogos/corrida/capa_xbox_one_2017_forza_7.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--ESPORTE
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Esporte', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarJogo('FIFA 18: World Cup', 'Multiplataforma', 2018, 'R\$ 68,50', 'assets/images/jogos/esporte/capa_multi_2018_fifa_18_cup.jpg'),
                  MostrarJogo('NBA 2K20', 'Multiplataforma', 2019, 'R\$ 85,50', 'assets/images/jogos/esporte/capa_multi_2019_nba_2k20.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--GUERRA
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Guerra', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarJogo('Battlefield 1', 'Multiplataforma', 2016, 'R\$ 67,50', 'assets/images/jogos/guerra/capa_multi_2016_battlefield_1.jpg'),
                  MostrarJogo('Battlefield V', 'Multiplataforma', 2018, 'R\$ 98,50', 'assets/images/jogos/guerra/capa_multi_2018_battlefield_5.jpg'),
                  MostrarJogo('Call Of Duty: Black Ops 4', 'Multiplataforma', 2018, 'R\$ 120,50', 'assets/images/jogos/guerra/capa_multi_2018_call_of_duty_black_ops_4.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--LUTA
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Luta', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarJogo('Street Fighter x Tekken', 'Multiplataforma', 2012, 'R\$ 34,50', 'assets/images/jogos/luta/capa_multi_2012_street_fighter_x_tekken.jpg'),
                  MostrarJogo('Street Fighter V', 'Multiplataforma', 2016, 'R\$ 54,50', 'assets/images/jogos/luta/capa_multi_2016_street_fighter_v.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--PLATAFORMA
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Plataforma', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarJogo('Super Lucky\'s Tale', 'Multiplataforma', 2012, 'R\$ 81,50', 'assets/images/jogos/plataforma/capa_multi_2017_super_luckys_tale.jpg'),
                  MostrarJogo('Super Mario 3D All Stars', 'Nintendo Switch', 2020, 'R\$ 179,50', 'assets/images/jogos/plataforma/capa_nintendo_switch_2020_super_mario_3d_all_stars.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--RPG
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Role-Playing Game', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarJogo('The Witcher III: Wild Hunt', 'Multiplataforma', 2015, 'R\$ 60,50', 'assets/images/jogos/rpg/capa_multi_2015_the_witcher_iii_wild_hunt.jpg'),
                  MostrarJogo('Bloodborne', 'PlayStation 4', 2015, 'R\$ 56,50', 'assets/images/jogos/rpg/capa_ps4_2015_bloodborne.jpg'),
                  MostrarJogo('Dark Souls III', 'PlayStation 4', 2016, 'R\$ 150,50', 'assets/images/jogos/rpg/capa_ps4_2016_dark_souls_iii.jpg'),
                  MostrarJogo('Dark Souls Remastered', 'PlayStation 4', 2018, 'R\$ 142,50', 'assets/images/jogos/rpg/capa_ps4_2018_dark_souls_remastered.jpg'),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}





//
//----------------- LIVROS
//
class TelaNavegarLivros extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      //no appBar

      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [

            //--ACADÊMICOS
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Acadêmicos', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                    //TelaLivroAcademico();
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarLivro('Alex Bastos', 'Programação Cobol', 1977, 'R\$ 3,50', 'assets/images/livros/academico/capa_alex_bastos_1977_programacao_cobol.jpg'),
                  MostrarLivro('Frank Zammetti', 'Flutter Na Prática', 2020, 'R\$ 90,50', 'assets/images/livros/academico/capa_frank_zammetti_2020_flutter_na_pratica.jpg'),
                  MostrarLivro('Miriam Joseph', 'O Trivium', 2002, 'R\$ 49,50', 'assets/images/livros/academico/capa_miriam_joseph_o_trivium.jpg'),
                  MostrarLivro('Paul Ekman', 'What The Face Reveals 2n Edition', 1997, 'R\$ 300,50', 'assets/images/livros/academico/capa_paul_ekman_1997_what_the_face_reveals_2nd_ed.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--AUTOAJUDA
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Autoajuda', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarLivro('Rápido E Devagar', 'Daniel Kahneman', 2012, 'R\$ 35,50', 'assets/images/livros/autoajuda/capa_daniel_kahneman_2012_rápido_e_devagar.jpg'),
                  MostrarLivro('Pai Rico Pai Pobre', 'Robert Kiyosaki', 2020, 'R\$ 70,50', 'assets/images/livros/autoajuda/capa_robert kiyosaki_1997_pai_rico_pai_pobre.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--BIOGRAFIA
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Biografia', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarLivro('Einstein, uma biografia', 'Jürgen Neffe', 2012, 'R\$ 70,50', 'assets/images/livros/biografia/capa_jurgen_neffe_2012_einstein_uma_biografia.jpg'),
                  MostrarLivro('Black Sabbath a biografia', 'Mick Wall', 2014, 'R\$ 60,50', 'assets/images/livros/biografia/capa_mick_wall_2014_black_sabbath_a_biografia.jpg'),
                  MostrarLivro('Steve Jobs', 'Walter Isaacson', 2015, 'R\$ 81,50', 'assets/images/livros/biografia/capa_walter_isaacson_2015_steve_jobs.jpg'),
                  MostrarLivro('Leonardo Da Vinci', 'Walter Isaacson', 2017, 'R\$ 70,50', 'assets/images/livros/biografia/capa_walter_isaacson_2017_leonardo_da_vinci.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--COMÉDIA
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Comédia', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarLivro('Chá de Sumiço', 'Marian Keyes', 2012, 'R\$ 35,50', 'assets/images/livros/comedia/capa_marian_keyes_2012_cha_de_sumico.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--FANTASIA
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Fantasia', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarLivro('O Festim Dos Corvos: As Crônicas de Gelo e Fogo IV', 'George R.R. Martin', 2005, 'R\$ 70,50', 'assets/images/livros/fantasia/capa_george_rr_martin_2005_o_festim_dos_corvos.jpg'),
                  MostrarLivro('Harry Potter e as Reliquias da Morte', 'J.K. Rowling', 2007, 'R\$ 45,50', 'assets/images/livros/fantasia/capa_jk_rowling_2007_harry_potter_e_as_reliquias_da_morte.jpg'),
                  MostrarLivro('O Hobbit', 'J.R.R Tolkien', 1937, 'R\$ 40,50', 'assets/images/livros/fantasia/capa_jrr_tolkien_1937_o_hobbit.jpg'),
                  MostrarLivro('O Nome Do Vento', 'Patrick Rothfuss', 2007, 'R\$ 41,50', 'assets/images/livros/fantasia/capa_patrick_rothfuss_2007_o_nome_do_vento.jpg'),
                  MostrarLivro('A Rainha Vermelha', 'Victoria Aveyard', 2015, 'R\$ 70,50', 'assets/images/livros/fantasia/capa_victoria_aveyard_2015_a_rainha_vermelha.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //-- HQ
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Histórias em Quadrinhos', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarLivro('V de Vingança', 'Alan Moore', 1982, 'R\$ 56,50', 'assets/images/livros/hq/capa_alan_moore_1982_v_de_vinganca.jpg'),
                  MostrarLivro('Batman: Cavalheiro das Trevas', 'Frank Miller', 1986, 'R\$ 78,50', 'assets/images/livros/hq/capa_frank_miller_1986_batman_cavalheiro_das_trevas.jpg'),
                  MostrarLivro('Batman: Ano Um', 'Frank Miller', 1988, 'R\$ 93,50', 'assets/images/livros/hq/capa_frank_miller_batman_1988_ano_um.jpg'),
                  MostrarLivro('Sandstorm Volume 1', 'Neil Gaiman', 1989, 'R\$ 49,50', 'assets/images/livros/hq/capa_neil_gaiman_1989_sandman_vol_1.jpg'),
                  MostrarLivro('Sandstorm Volume 3', 'Neil Gaiman', 1989, 'R\$ 52,50', 'assets/images/livros/hq/capa_neil_gaiman_1989_sandman_vol_3.jpg'),
                  MostrarLivro('Sandstorm Volume 4', 'Neil Gaiman', 1989, 'R\$ 49,00', 'assets/images/livros/hq/capa_neil_gaiman_1989_sandman_vol_4.jpg'),
                  MostrarLivro('Amazing Fantasy #15 Spider Man', 'Stan Lee', 1962, 'R\$ 230,50', 'assets/images/livros/hq/capa_stan_lee_1962_amazing_fantasy_15_spider_man.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--ROMANCE
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Romance', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style:  Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 374.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarLivro('O Morro Dos Ventos Uivantes', 'Emilly Bronte', 2011, 'R\$ 46,50', 'assets/images/livros/romance/capa_emily_bronte_2011_o_morro_dos_ventos_uivantes.jpg'),
                  MostrarLivro('A Culpa É Das Estrelas', 'John Green', 2012, 'R\$ 46,50', 'assets/images/livros/romance/capa_john_green_2012_a_culpa_e_das_estrelas.jpg'),
                  MostrarLivro('Dom Casmurro', 'Machado De Assis', 1899, 'R\$ 46,50', 'assets/images/livros/romance/capa_machado_de_assis_1899_dom_casmurro.jpg'),
                  MostrarLivro('Meu Anjo Caído (Romances Angelicais Livro 1)', 'Patrizia Evans', 2017, 'R\$ 2,99', 'assets/images/livros/romance/capa_patrizia_evans_2017_meu_anjo_caido.jpg'),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}





//
//----------------- MÚSICAS
//
class TelaNavegarMusicas extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      //no appBar

      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [

            //-- BLUES
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Blues', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style: Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                    //TelaMusicaBlues();
                  }
                ),
              ),
            ),
            SizedBox(
              height: 300.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarAlbum('King Size', 'B.B. King', 1977, 'R\$ 26,50', 'assets/images/musicas/blues/capa_bbking_1977_king_size.jpg'),
                  MostrarAlbum('From The Cradle', 'Eric Clapton', 1994, 'R\$ 50,50', 'assets/images/musicas/blues/capa_eric_clapton_1994_from_the_cradle.jpg'),
                  MostrarAlbum('Self Made Man', 'Larkin Poe', 2020, 'R\$ 80,50', 'assets/images/musicas/blues/capa_larkin_poe_2020_self_made_man.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--COUNTRY
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Country', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style: Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 300.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarAlbum('At San Quetin', 'Johnny Cash', 1969, 'R\$ 35,50', 'assets/images/musicas/country/capa_johnny_cash_1969_at_san_quentin.jpg'),
                  MostrarAlbum('American Recordings', 'Johnny Cash', 1994, 'R\$ 40,50', 'assets/images/musicas/country/capa_johnny_cash_1994_american_recordings.jpg'),
                  MostrarAlbum('Fearless', 'Taylor Swift', 2008, 'R\$ 30,50', 'assets/images/musicas/country/capa_taylor_swift_2008_fearless.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--FOLK
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Folk', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style: Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 300.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarAlbum('Origins', 'Eluveitie', 2014, 'R\$ 75,50', 'assets/images/musicas/folk/capa_eluveitie_2014_origins.jpg'),
                  MostrarAlbum('Patty Griffin', 'Patty Griffin', 2019, 'R\$ 40,50', 'assets/images/musicas/folk/capa_patty_griffin_2019_patty_griffin.jpg'),
                  MostrarAlbum('Barton Hollow', 'The Civil Wars', 2018, 'R\$ 41,50', 'assets/images/musicas/folk/capa_the_civil_wars_2018_barton_hollow.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--FUNK
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Funk', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style: Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 300.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarAlbum('It\'s Got To Be Funky', 'Horace Silver', 1993, 'R\$ 20,00', 'assets/images/musicas/funk/capa_horace_silver_1993_its_got_to_be_funky.jpg'),
                  MostrarAlbum('Reality', 'James Brown', 1974, 'R\$ 23,50', 'assets/images/musicas/funk/capa_james_brown_1974_reality.jpg'),
                  MostrarAlbum('The Singles Vol. 4', 'James Brown', 2009, 'R\$ 41,50', 'assets/images/musicas/funk/capa_james_brown_2009_the_singles_vol_7.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--JAZZ
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Jazz', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style: Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 300.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarAlbum('Kind Of Blues', 'Miles Davis', 1959, 'R\$ 27,00', 'assets/images/musicas/jazz/capa_miles_davis_1959_kind_of_blues.jpg'),
                  MostrarAlbum('Source', 'Nubya Garcia', 2020, 'R\$ 30,50', 'assets/images/musicas/jazz/capa_nubya_garcia_2020_source.jpg'),
                  MostrarAlbum('Saxophone Colossus', 'Sonny Rollins', 1956, 'R\$ 26,50', 'assets/images/musicas/jazz/capa_sonny_rollins_1956_saxophone_colossus.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--METAL
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Metal', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style: Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 300.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarAlbum('Paranoid', 'Black Sabbath', 1970, 'R\$ 30,00', 'assets/images/musicas/metal/capa_black_sabbath_1970_paranoid.jpg'),
                  MostrarAlbum('Human', 'Darkwater', 2019, 'R\$ 67,50', 'assets/images/musicas/metal/capa_darkwater_2019_human.jpg'),
                  MostrarAlbum('Train Of Tought', 'Dream Theater', 2003, 'R\$ 30,00', 'assets/images/musicas/metal/capa_dream_theater_2003_train_of_tought.jpg'),
                  MostrarAlbum('Origins', 'Eluveitie', 2014, 'R\$ 75,50', 'assets/images/musicas/metal/capa_eluveitie_2014_origins.jpg'),
                  MostrarAlbum('Fallen', 'Evanescence', 2004, 'R\$ 29,00', 'assets/images/musicas/metal/capa_evanescence_2004_fallen.jpg'),
                  MostrarAlbum('III', 'Maylene & The Sons Of Disaster', 2009, 'R\$ 48,50', 'assets/images/musicas/metal/capa_maylene_et_the_sons_of_disaster_2009_iii.jpg'),
                  MostrarAlbum('Pintando Quadros No Invísivel', 'Ponto Nulo No Céu', 2016, 'R\$ 48,50', 'assets/images/musicas/metal/capa_ponto_nulo_no_ceu_2016_pintando_quadros_no_invisivel.jpg'),
                  MostrarAlbum('Titans Of Creation', 'Testament', 2020, 'R\$ 45,50', 'assets/images/musicas/metal/capa_testament_2020_titans_of_creation.jpg'),
                  MostrarAlbum('A Essência Do Medo', 'Theoria De Allice', 2020, 'R\$ 45,50', 'assets/images/musicas/metal/capa_theoria_de_allice_2012_a_essencia_do_medo.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--POP
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Pop', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style: Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 300.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarAlbum('25', 'Adele', 2015, 'R\$ 19,00', 'assets/images/musicas/pop/capa_adele_2015_adele_25.jpg'),
                  MostrarAlbum('Ghost Stories', 'Coldplay', 2014, 'R\$ 52,00', 'assets/images/musicas/pop/capa_coldplay_2014_ghost_stories.jpg'),
                  MostrarAlbum('Thriller', 'Michael Jackson', 1982, 'R\$ 43,50', 'assets/images/musicas/pop/capa_michael_jackson_1982_thriller.jpg'),
                  MostrarAlbum('Blood On The Dance Floor', 'Michael Jackson', 1997, 'R\$ 120,50', 'assets/images/musicas/pop/capa_michael_jackson_1997_blood_on_the_dance_floor.jpg'),
                  MostrarAlbum('Lover', 'Taylor Swift', 2019, 'R\$ 80,50', 'assets/images/musicas/pop/capa_taylor_swift_2019_lover.jpg'),
                  MostrarAlbum('Folklore', 'Taylor Swift', 2020, 'R\$ 56,50', 'assets/images/musicas/pop/capa_taylor_swift_2020_folklore.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--ROCK
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Rock', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style: Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 300.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarAlbum('Back In Black', 'AC/DC', 1980, 'R\$ 21,50', 'assets/images/musicas/rock/capa_acdc_1980_back_in_black.jpg'),
                  MostrarAlbum('Shot In The Dark (Single)', 'AC/DC', 2020, 'R\$ 12,50', 'assets/images/musicas/rock/capa_acdc_2020_shot_in_dark.jpg'),
                  MostrarAlbum('Sua Alegria Foi Cancelada', 'Freseno', 1980, 'R\$ 17,50', 'assets/images/musicas/rock/capa_fresno_2019_sua_alegria_foi_cancelada.jpg'),
                  MostrarAlbum('Destroyer', 'Kiss', 1974, 'R\$ 60,50', 'assets/images/musicas/rock/capa_kiss_1974_destroyer.jpg'),
                  MostrarAlbum('Hard Blues Shot', 'Laura Cox', 2017, 'R\$ 80,50', 'assets/images/musicas/rock/capa_laura_cox_band_2017_hard_blues_shot.jpg'),
                  MostrarAlbum('The White Album', 'The Beatles', 1968, 'R\$ 26,50', 'assets/images/musicas/rock/capa_the_beatles_1968_the_white_album.jpg'),
                  MostrarAlbum('Wolfmother (EP)', 'Wolfmother', 2000, 'R\$ 26,50', 'assets/images/musicas/rock/capa_wolfomother_2000_wolfmother_ep.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--SERTANEJO
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Sertanejo', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style: Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 300.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarAlbum('Marília Mendonça Ao Vivo', 'Marília Mendonça', 2017, 'R\$ 26,50', 'assets/images/musicas/sertanejo/capa_marilia_mendonca_2016_ao_vivo.jpg'),
                  MostrarAlbum('Michel Teló Ao Vivo', 'Michel Teló', 2010, 'R\$ 17,50', 'images/musicas/sertanejo/capa_michel_telo_2010_ao_vivo.jpg'),
                ],
              ),
            ),

            SizedBox(height: 30),

            //--TRILHAS SONORAS
            //
            Padding(
              padding: const EdgeInsets.only(bottom: -20),
              child: Text('Trilhas Sonoras', style: Theme.of(context).textTheme.headline4),
            ),
             Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Ver mais...',
                  style: Theme.of(context).textTheme.bodyText2,
                  recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    //link pro genero
                  }
                ),
              ),
            ),
            SizedBox(
              height: 300.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MostrarAlbum('Game Of Thrones 3ª Temporada', 'Ramin Djwadi', 2013, 'R\$ 60,50', 'images/musicas/trilha/capa_game_of_thrones_trilha_2013_3_temp.jpg'),
                  MostrarAlbum('Game Of Thrones 5ª Temporada', 'Ramin Djwadi', 2015, 'R\$ 63,50', 'images/musicas/trilha/capa_game_of_thrones_trilha_2015_5_temp.jpg'),
                  MostrarAlbum('Star Wars Episode I', 'John Williams', 1999, 'R\$ 70,50', 'images/musicas/trilha/capa_star_wars_episode_i.jpg'),
                  MostrarAlbum('Bohemiam Rhapsody', 'Queen', 1999, 'R\$ 30,50', 'images/musicas/trilha/capa_queen_2019_bohemian_rhapsody.jpg'),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}