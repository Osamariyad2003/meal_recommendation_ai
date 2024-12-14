
import '../../domain/repo/sidebar_repo.dart';
import '../data_source/remote_data_source.dart';
import '../models/header_model.dart';
class SidebarRepoImp  implements SidebarRepo {
  final RemoteSideBarDataSource remoteDataSource;
  SidebarRepoImp(this.remoteDataSource);
  @override
  Future<HeaderModel?> getHeader({required String uid}) async{
    final HeaderModel model = await remoteDataSource.getHeader(uid: uid);
    return HeaderModel(
       path:  model.path??"",
       name:  model.name,
      uid:  model.uid


    );
  }

  @override
  Future<void> signOut() async {
   await remoteDataSource.signOut();
   // CacheKeys.cachedUserId == null;

  }




}
