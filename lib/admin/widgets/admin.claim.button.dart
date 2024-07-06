import 'package:flutter/material.dart';
import 'package:model_house/admin/admin.service.dart';
import 'package:model_house/model_house.dart';

class AdminClaimButton extends StatelessWidget {
  const AdminClaimButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final admins = await AdminService.instance.getAdmins();
        if (admins != null) {
          if (context.mounted) {
            alert(
                context: context,
                title: 'admin_exist'.t,
                message: 'admin_exist_message'.t);
          }
          return;
        }
        await AdminService.instance.claimAsRoot();
        if (context.mounted) {
          alert(
              context: context,
              title: 'admin_claimed'.t,
              message: 'admin_claimed_message'.t);
        }
      },
      child: const Text('Admin Claim Button'),
    );
  }
}
