import 'package:flutter/material.dart';
import 'package:model_house/admin/admin.service.dart';

class AdminClaimButton extends StatelessWidget {
  const AdminClaimButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await AdminService.instance.claimAsRoot();
      },
      child: const Text('Admin Claim Button'),
    );
  }
}
