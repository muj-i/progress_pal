import 'package:get/get.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/model/summary_count_model.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/urls.dart';

class SummaryCountController extends GetxController {
  bool _getSummaryCountInProgress = false;
  SummaryCountModel summaryCountModel = SummaryCountModel();
  bool get getSummaryCountInProgress => _getSummaryCountInProgress;
  SummaryCountModel get getSummaryCountModel => summaryCountModel;

  void sortSummaryData() {
    getSummaryCountModel.data?.sort((a, b) {
      final aId = a.sId ?? '';
      final bId = b.sId ?? '';
      return aId.compareTo(bId);
    });
  }

  Future<bool> getSummaryCount() async {
    _getSummaryCountInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.summaryCardCount);

    _getSummaryCountInProgress = false;

    if (response.isSuccess) {
      summaryCountModel = SummaryCountModel.fromJson(response.body!);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}
