import 'package:flutter/material.dart';
import 'package:tp7/entities/classe.dart';
import 'package:tp7/service/classeservice.dart';

class ClasseScreen extends StatefulWidget {
  const ClasseScreen({super.key});

  @override
  _ClasseScreenState createState() => _ClasseScreenState();
}

class _ClasseScreenState extends State<ClasseScreen> {
  List<Classe> classes = [];
  final _formKey = GlobalKey<FormState>();
  final _nomClasseController = TextEditingController();
  final _nbreEtudController = TextEditingController();

  // Méthode pour récupérer toutes les classes
  void getAllClasses() async {
    try {
      var result = await ClasseService.getAllClasses();
      setState(() {
        classes = result;
      });
    } catch (e) {
      print('Error fetching classes: $e');
    }
  }

  // Méthode pour ajouter une nouvelle classe
  void ajouterClasse() async {
    if (_formKey.currentState?.validate() ?? false) {
      Classe nouvelleClasse = Classe(
        int.parse(_nbreEtudController.text),
        _nomClasseController.text,
      );

      try {
        await ClasseService.addClass(nouvelleClasse); // Ajouter la classe
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Classe ajoutée avec succès!')),
        );
        getAllClasses(); // Rafraîchir la liste des classes
        Navigator.pop(context); // Fermer le formulaire après ajout
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur lors de l\'ajout de la classe')),
        );
      }
    }
  }

  // Méthode pour supprimer une classe
  void deleteClass(int classId) async {
    try {
      await ClasseService.deleteClass(classId);
      getAllClasses(); // Rafraîchir la liste après suppression
    } catch (e) {
      print('Error deleting class: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getAllClasses(); // Initial fetch of classes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Class List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Ajouter une classe"),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _nomClasseController,
                            decoration: const InputDecoration(
                              labelText: 'Nom de la classe',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer le nom de la classe';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _nbreEtudController,
                            decoration: const InputDecoration(
                              labelText: 'Nombre d\'étudiants',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer le nombre d\'étudiants';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Fermer le formulaire
                        },
                        child: const Text('Annuler'),
                      ),
                      ElevatedButton(
                        onPressed: ajouterClasse,
                        child: const Text('Ajouter'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: classes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(classes[index].nomClass),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                deleteClass(classes[index].codClass ?? 0);
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ClasseDetailScreen(classe: classes[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ClasseDetailScreen extends StatelessWidget {
  final Classe classe;

  const ClasseDetailScreen({super.key, required this.classe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(classe.nomClass),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Class Details: ${classe.nomClass}'),
      ),
    );
  }
}
