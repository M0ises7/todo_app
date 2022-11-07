// ignore_for_file: file_names, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';
import '../../controller/models/tarea_models.dart';
import '../../observables/app_management.dart';

// ignore: must_be_immutable
class FormNuevo extends StatefulWidget {
  TareaModel? tareaModel;
  AppManagement? appManagement;
  FormNuevo({super.key, this.tareaModel, this.appManagement});

  @override
  State<FormNuevo> createState() =>
      // ignore: no_logic_in_create_state
      _FormNuevoState(
          hayTarea: tareaModel == null, appManagement: appManagement);
}

class _FormNuevoState extends State<FormNuevo> {
  final bool hayTarea;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreTareaControler;
  late TextEditingController _descripcionTareaControler;
  late TextEditingController _nombreDeClase;
  late TextEditingController completadaClase;
  late TextEditingController fechaInput;
  _FormNuevoState({required this.hayTarea, AppManagement? appManagement});
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    _nombreTareaControler = TextEditingController();
    _descripcionTareaControler = TextEditingController();
    _nombreDeClase = TextEditingController();
    completadaClase = TextEditingController();
    fechaInput = TextEditingController();
    _nombreTareaControler.text =
        (hayTarea) ? "" : widget.tareaModel!.nombreTarea;
    _descripcionTareaControler.text =
        (hayTarea) ? "" : widget.tareaModel!.descripcionTarea;
    _nombreDeClase.text = (hayTarea) ? "" : widget.tareaModel!.nombreClase;
    fechaInput.text = (hayTarea) ? "" : widget.tareaModel!.fechaTarea;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppManagement appManagement = Provider.of<AppManagement>(context);
    List<TareaModel>? tasks = appManagement.observerTasks;
    tasks.where((element) => element.completadaTarea == true);
    return Scaffold(
      appBar: AppBar(title: const Text("Nueva tarea")),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.symmetric(vertical: 16)),
                TextFormField(
                  controller: _nombreTareaControler,
                  validator: (value) =>
                      (value!.isEmpty ? 'Nombre de tarea es requerido' : null),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.assignment),
                    border: OutlineInputBorder(),
                    labelText: 'Nombre de la tarea',
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 16)),
                TextFormField(
                  controller: _nombreDeClase,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.account_box),
                    border: OutlineInputBorder(),
                    labelText: 'Tipo de Tarea',
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 16)),
                TextFormField(
                  controller: _descripcionTareaControler,
                  maxLines: 3,
                  validator: (value) =>
                      (value!.isEmpty ? 'Descripcion es requerido' : null),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                    labelText: 'Detalles',
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 16)),
                TextFormField(
                  controller: fechaInput,
                  validator: (value) =>
                      (value!.isEmpty ? 'La fecha es requerida' : null),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Fecha" //label text of field
                      ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100));
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(
                        () {
                          fechaInput.text = formattedDate;
                        },
                      );
                    }
                  },
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                const SizedBox(
                  height: 120,
                ),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () async =>
                        await guardarTarea(appManagement, tasks),
                    child: (hayTarea)
                        ? const Text("Guardar")
                        : const Text("Actualizar"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  guardarTarea(AppManagement appManagement, tasks) async {
    if (_formKey.currentState!.validate()) {
      if (hayTarea) {
        Controller.insertTask(
          TareaModel(
              nombreTarea: _nombreTareaControler.text,
              nombreClase: (_nombreDeClase.text.isNotEmpty)
                  ? _nombreDeClase.text
                  : "General",
              descripcionTarea: _descripcionTareaControler.text,
              completadaTarea: false,
              fechaTarea: fechaInput.text),
        );
        appManagement.setAsyncTask();
        Navigator.pop(context);
      } else {
        TareaModel tm = TareaModel(
            idTarea: widget.tareaModel!.idTarea,
            nombreTarea: _nombreTareaControler.text,
            nombreClase: (_nombreDeClase.text.isNotEmpty)
                ? _nombreDeClase.text
                : "General",
            descripcionTarea: _descripcionTareaControler.text,
            completadaTarea: false,
            fechaTarea: fechaInput.text);
        await Controller.updateTasks([tm]);
        appManagement.setAsyncTask();
        Navigator.pop(context);
      }
    }
  }
}
