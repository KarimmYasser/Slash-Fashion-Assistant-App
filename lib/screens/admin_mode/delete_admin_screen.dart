import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/authentication.repository/login_data.dart';
import '../../utils/http/http_client.dart';

class DeleteAdminScreen extends StatelessWidget {
  const DeleteAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DeleteAdminController controller = Get.put(DeleteAdminController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Delete Admin'),
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Sizes.spaceBtwItems),
            child: IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Info'),
                      content: const Text('Drag left to delete an admin.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.adminList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.adminList.length,
          itemBuilder: (context, index) {
            final admin = controller.adminList[index];
            return Dismissible(
              key: Key(admin.id!),
              direction: DismissDirection.endToStart,
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Confirm'),
                      content: const Text(
                          'Are you sure you want to delete this admin?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              },
              onDismissed: (direction) {
                controller.deleteAdmin(index);
                Loaders.successSnackBar(
                    title: '${admin.username} deleted',
                    message: 'Admin deleted successfully');
              },
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red.shade400, Colors.red.shade900],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: OurColors.primaryColor,
                    child: Text(
                      admin.username![0].toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    admin.username!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        admin.role!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        admin.email!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class DeleteAdminController extends GetxController {
  var adminList = <AdminData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAdmins();
  }

  void fetchAdmins() async {
    try {
      var response = await HttpHelper.get('api/admin');
      var admins = response['admins'] as List;
      var adminDataList = admins.map((admin) => AdminData(admin)).toList();
      adminList.assignAll(adminDataList);
    } catch (e) {
      Loaders.errorSnackBar(
          title: 'Failed to fetch admins', message: e.toString());
    }
  }

  void deleteAdmin(int index) async {
    try {
      await HttpHelper.delete('api/admin/${adminList[index].id}', {
        'id': adminList[index].id,
      });
      adminList.removeAt(index);
    } catch (e) {
      Loaders.errorSnackBar(
          title: 'Failed to delete admin', message: 'Please try again');
    }
  }
}
