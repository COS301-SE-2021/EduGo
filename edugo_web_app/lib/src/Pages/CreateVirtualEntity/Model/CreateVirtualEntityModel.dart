import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/Model/Data/ArModel.dart';
import 'package:edugo_web_app/src/Pages/CreateVirtualEntity/View/Widgets/VirtualEntityInfoAdderCard.dart';
import 'package:edugo_web_app/src/Pages/EduGo.dart';

class CreateVirtualEntityModel
    extends MomentumModel<CreateVirtualEntityController> {
  final String name;
  final String modelLink;
  final ArModel arModel;
  final bool loadingModelLink;
  final bool creatingEntityLoader;
  final String createEntityResponse;
  final String currentInfoInput;
  final List<String> informationString;
  final List<Widget> informationCards;
  CreateVirtualEntityModel(CreateVirtualEntityController controller,
      {this.name,
      this.currentInfoInput,
      this.informationCards,
      this.loadingModelLink,
      this.informationString,
      this.modelLink,
      this.arModel,
      this.createEntityResponse,
      this.creatingEntityLoader})
      : super(controller);

  void setCreateVirtualEntityName(String inName) {
    update(name: inName);
  }

  void setCreateVirtualEntityDescription() {
    List<String> stringArr = [];
    stringArr = informationString;
    stringArr.add(currentInfoInput);
    update(informationString: stringArr);
  }

  void setCreateVirtualEntityModelLink(String inModelLink) {
    update(modelLink: inModelLink);
  }

  void clearLinkTo3DModel() {
    update(modelLink: "");
  }

  String getCreateVirtualEntityName() {
    return name;
  }

  void getInfoView() {
    List<Widget> infoCards = [];
    int id = 0;
    infoCards.add(
      SizedBox(
        height: 20,
      ),
    );
    informationString.forEach(
      (email) {
        infoCards.add(VirtualEntityInfoAdderCard(infoId: id, infoValue: email));
        infoCards.add(
          SizedBox(
            height: 20,
          ),
        );
        id++;
      },
    );

    update(informationCards: infoCards);
  }

  @override
  void update(
      {String modelLink,
      String name,
      List<String> informationString,
      ArModel arModel,
      bool loadingModelLink,
      String createEntityResponse,
      bool creatingEntityLoader,
      String currentInfoInput,
      List<Widget> informationCards}) {
    CreateVirtualEntityModel(controller,
            name: name ?? this.name,
            informationString: informationString ?? this.informationString,
            modelLink: modelLink ?? this.modelLink,
            arModel: arModel ?? this.arModel,
            loadingModelLink: loadingModelLink ?? this.loadingModelLink,
            createEntityResponse:
                createEntityResponse ?? this.createEntityResponse,
            creatingEntityLoader:
                creatingEntityLoader ?? this.creatingEntityLoader,
            currentInfoInput: currentInfoInput ?? this.currentInfoInput,
            informationCards: informationCards ?? this.informationCards)
        .updateMomentum();
  }
}
