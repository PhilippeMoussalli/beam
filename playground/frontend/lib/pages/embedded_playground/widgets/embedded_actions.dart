/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// ignore_for_file: unsafe_html

import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playground_components/playground_components.dart';
import 'package:provider/provider.dart';

import '../../../constants/assets.dart';
import '../../../constants/sizes.dart';
import '../../../modules/messages/models/set_content_message.dart';
import '../../../utils/javascript_post_message.dart';
import '../../standalone_playground/path.dart';

const kTryPlaygroundButtonWidth = 200.0;
const kTryPlaygroundButtonHeight = 40.0;

class EmbeddedActions extends StatelessWidget {
  const EmbeddedActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kMdSpacing),
      child: SizedBox(
        width: kTryPlaygroundButtonWidth,
        height: kTryPlaygroundButtonHeight,
        child: Consumer<PlaygroundController>(
          builder: (context, controller, child) => ElevatedButton.icon(
            icon: SvgPicture.asset(kLinkIconAsset),
            label: Text(AppLocalizations.of(context)!.tryInPlayground),
            onPressed: () => _openStandalonePlayground(controller),
          ),
        ),
      ),
    );
  }

  void _openStandalonePlayground(PlaygroundController controller) {
    final window = html.window.open(
      StandalonePlaygroundWaitPath().location,
      '',
    );

    final descriptor = controller.getLoadingDescriptor();
    javaScriptPostMessageRepeated(
      window,
      SetContentMessage(
        descriptor: descriptor,
      ),
    );
  }
}
