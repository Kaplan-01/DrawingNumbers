import 'package:flutter/material.dart';
import 'constants.dart';
import 'painter.dart';
import 'inference.dart';


class mainScreen  extends StatefulWidget{
  @override
  _mainScreenState createState() => _mainScreenState();

}
class _mainScreenState extends State<mainScreen>{
  AppBrain inferencia = AppBrain(); //clase que carga el modelo
  List<Offset> points = List(); //Puntos de canvas
  @override
  void initState(){
    super.initState();
    inferencia.loadModel();//Modelo de tflite(carga)
  }
var prediction;
var predictionNum;
var total;


  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title: Text('Painter'),
          centerTitle: true,
          backgroundColor: Colors.pinkAccent,
          //      title: Text(widget.title),
        ),
        body: Container( //SE PUEDE REMOVER
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                //flex: 1,
                child: Container(
                  padding: EdgeInsets.all(16),
                  //                color: Colors.red,
                  alignment: Alignment.center,
                  child: Text('Write a number: '),
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  border: new Border.all(
                    width: 4.0,
                    color: Colors.green,
                  ),
                ),
                child: Builder( //Detector de Gestos en Pantalla //Child from the container
                  builder: (BuildContext context) {
                    return GestureDetector( //Revisar clase
                      onPanUpdate: (details) {
                        setState(() {
                          RenderBox renderBox = context.findRenderObject();
                          points.add(
                              renderBox.globalToLocal(details.globalPosition));
                        });
                      },
                      onPanStart: (details) {
                        setState(() {
                          RenderBox renderBox = context.findRenderObject();
                          points.add(
                              renderBox.globalToLocal(details.globalPosition));
                        });
                      },
                      onPanEnd: (details) async { //Modificar a async
                        //setState(() async {
                        points.add(null); //PINTAR
                        List predictions = await inferencia.processCanvasPoints(points); //Se pasan los puntos para edicion
                        String inte = predictions.toString();
                        prediction = ("${predictions[0]["confidence"]}").toString();
                        predictionNum = ("${predictions[0]["label"]}").toString();

                        print("La red predice: ");
                        print(inte);
                        print(prediction);
                        print(inte);
                        print(predictionNum);
                        total = "Coincidencia: " + prediction + " " + " " + "Numero: " + predictionNum;
                        //Aqui se obtienen las predicciones

                        final snackBar = SnackBar(
                          backgroundColor: Colors.teal,
                          content: Text(total),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);

                        setState(() {});
                        //});
                      },

                        child: ClipRect( //By default, ClipRect prevents its child from painting outside its bounds, but the size and location of the clip rect can be customized using a custom clipper.
                        child: CustomPaint( //A widget that provides a canvas on which to draw during the paint phase.
                          size: Size(kCanvasSize, kCanvasSize),
                          //En la clase constants
                          painter: painter( //Clase Propia usamos un Painter Personalizado
                            offsetPoints: points, //Puntos recolectados del método de arriba
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                //flex: 1,
                child: Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: MaterialButton(
                    child: Text("Clean"),
                    color: Colors.orange,
                    onPressed: () {
                      points.clear();
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
  _showSnackbar(BuildContext context, String inte){
    final snackBar=SnackBar(
        content: new Text(inte)
    );
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }
}