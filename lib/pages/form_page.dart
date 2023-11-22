import 'package:flutter/material.dart';
import 'package:gs_2/pages/result_page.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final ageController = TextEditingController();
  String generoFinal =  "";
  String nivelFinal =  "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorias diárias'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildAge(),
                const SizedBox(height: 20),
                _buildGender(),
                const SizedBox(height: 20),
                _buildWeight(),
                const SizedBox(height: 20),
                _buildHeight(),
                const SizedBox(height: 20),
                _buildActivityLevel(),
                const SizedBox(height: 20),
                _buildButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildAge() {
    return TextFormField(
      controller: ageController,
      validator: (String? age) {
        int? idade  = int.tryParse(age!);
        if (idade == null ) {
          return "Por favor, digite sua idade";
        } else if (idade < 0 || idade  > 80) {
          return "A idade deve ser maior que 0 e menor que 80 anos";
        }
        return null;
      },
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'Informe sua idade',
        labelText: 'Idade',
        border: OutlineInputBorder(),
      ),
    );
  }

  _buildGender() {
    return DropdownButtonFormField(
       validator: (String? genero) {
      
        if (genero == null) {
          return "Por favor, selecione seu genero";
        } 
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Informe seu gênero',
        labelText: 'Gênero',
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(
          value: 'male',
          child: Text('Masculino'),
        ),
        DropdownMenuItem(
          value: 'female',
          child: Text('Feminino'),
        ),
      ],
      onChanged: (value) {
        if(value != null){
        generoFinal = value;
         }
      }
    );
  }

  _buildWeight() {
    return TextFormField(
      controller: weightController,
      validator: (String? weigth) {
        int? peso  = int.tryParse(weigth!);
        if (peso == null ) {
          return "Por favor, digite seu peso";
        } else if (160 < peso || peso < 40) {
          return "O peso deve ser menor que 160 e maior que 40";
        }
        return null;
      },
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'Informe seu peso (kg)',
        labelText: 'Peso',
        border: OutlineInputBorder(),
      ),
    );
  }

  _buildHeight() {
    return TextFormField(
      controller: heightController,
      validator: (String? height) {
      
        int? altura  = int.tryParse(height!);
        if (altura == null) {
          return "Por favor, digite seu altura";
        } else if ( 130 > altura || altura > 230) {
          return "A altura deve ser maior que 130 e menor que 230";
        }
        return null;
      },
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'Informe sua altura (cm)',
        labelText: 'Altura',
        border: OutlineInputBorder(),
      ),
    );
  }

  _buildActivityLevel() {
    return DropdownButtonFormField(
      validator: (String? level) {
      
    
        if (level == null) {
          return "Por favor, selecione um nível";
        } 
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Informe seu nível de atividade física',
        labelText: 'Nível de atividade',
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(
          value: 'level_1',
          child: Text('Sedentário: pouco ou nenhum exercício'),
        ),
        DropdownMenuItem(
          value: 'level_2',
          child: Text('Exercício 1-3 vezes/semana'),
        ),
        DropdownMenuItem(
          value: 'level_3',
          child: Text('Exercício 4-5 vezes/semana'),
        ),
        DropdownMenuItem(
          value: 'level_4',
          child: Text('Exercício diário ou exercício intenso 3-4 vezes/semana'),
        ),
        DropdownMenuItem(
          value: 'level_5',
          child: Text('Exercício intenso 6-7 vezes/semana'),
        ),
        DropdownMenuItem(
          value: 'level_6',
          child:
              Text('Exercício muito intenso diariamente, ou trabalho físico'),
        ),
      ],
      onChanged: (value) {
        if(value != null){
          nivelFinal = value;
        }
        
      },
    );
  }

  SizedBox _buildButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Calcular',
            style: TextStyle(fontSize: 20),
          ),
        ),
        onPressed: () async {

    if (_formKey.currentState!.validate()) {

      Navigator.push(context, MaterialPageRoute<void>(
          builder: (BuildContext context) => ResultPage(   
            valorIdade:ageController.text,
            valorGenero: generoFinal,
            valorPeso: weightController.text,
            valorAltura: heightController.text,
            nivel: nivelFinal),),
      );
    }
  
        },
      ),
    );
  }
}
