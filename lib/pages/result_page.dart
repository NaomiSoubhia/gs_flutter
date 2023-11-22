// ReesultPage é a tela que exibe o resultado do calculo de calorias diáriasT
import 'package:flutter/material.dart';
import 'package:gs_2/api/fitness_calculator_api.dart';
import 'package:gs_2/models/daily_calorie.dart';

class ResultPage extends StatefulWidget {
  final String valorIdade;
  final String valorGenero;
  final String valorPeso;
  final String valorAltura;
  final String nivel;

  const ResultPage({
    super.key,
    required this.valorIdade,
    required this.valorGenero,
    required this.valorPeso,
    required this.valorAltura,
    required this.nivel,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final api = FitnessCalculatorApi();
  late Future<DailyCalorie?> _futureDailyCalorie;

  @override
  void initState() {
    super.initState();
    _futureDailyCalorie = api.getDailyCalories(widget.valorIdade,
        widget.valorGenero, widget.valorPeso, widget.valorAltura, widget.nivel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calorias diárias'),
        ),
        // Remove o Widgt de center e add o FutureBuilder para exibir o resultado
        body: FutureBuilder(
          future: _futureDailyCalorie,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              
              return _buildResult(snapshot.data!);
            }
            return Container();
          },
        ));
  }

  _buildResult(DailyCalorie calorie) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Metabolismo basal'),
          subtitle: Text(
            '${calorie.bMR}',
          ),
        ),
        ListTile(
          title: const Text('Manter o peso'),
          subtitle: Text(
            '${calorie.goals?.maintainWeight}',
          ),
        ),
        ListTile(
          title: Text(
              'Perda leve de peso ${calorie.goals?.mildWeightLoss?.lossWeight}'),
          subtitle: Text(
            '${calorie.goals?.mildWeightLoss?.calory}',
          ),
        ),
        ListTile(
          title: Text('Perda de peso ${calorie.goals?.weightLoss?.lossWeight}'),
          subtitle: Text(
            '${calorie.goals?.weightLoss?.calory}',
          ),
        ),
        ListTile(
          title: Text(
              'Perda extrema de peso ${calorie.goals?.extremeWeightLoss?.lossWeight}'),
          subtitle: Text(
            '${calorie.goals?.extremeWeightLoss?.calory}',
          ),
        ),
        ListTile(
          title: Text(
              'Ganho leve de peso ${calorie.goals?.mildWeightGain?.gainWeight}'),
          subtitle: Text(
            '${calorie.goals?.mildWeightGain?.calory}',
          ),
        ),
        ListTile(
          title: Text('Ganho de peso ${calorie.goals?.weightGain?.gainWeight}'),
          subtitle: Text(
            '${calorie.goals?.weightGain?.calory}',
          ),
        ),
        ListTile(
          title: Text(
              'Ganho extremo de peso ${calorie.goals?.extremeWeightGain?.gainWeight}'),
          subtitle: Text(
            '${calorie.goals?.extremeWeightGain?.calory}',
          ),
        ),
      ],
    );
  }
}
