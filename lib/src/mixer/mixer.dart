import 'package:flutter/material.dart';
import 'package:mix/src/attributes/icon/icon.attributes.dart';
import 'package:mix/src/attributes/text/text.attributes.dart';

import '../../mix.dart';
import '../attributes/box/box.attributes.dart';
import '../attributes/common/attribute.dart';
import '../attributes/directives/text/text_directive.attributes.dart';
import '../attributes/flex/flex.attributes.dart';
import '../attributes/shared/shared.attributes.dart';

typedef AttributeGetter<T extends Attribute> = List<Attribute>? Function(
    T attribute);

class Mixer {
  BuildContext context;
  BoxAttributes? box;
  TextAttributes? text;
  SharedAttributes? shared;
  IconAttributes? icon;
  FlexAttributes? flex;
  List<DynamicAttribute> dynamicProps;
  List<TokenRefAttribute> tokens;
  List<DirectiveAttribute> directives;

  Mixer._({
    required this.context,
    this.box,
    this.text,
    this.shared,
    this.icon,
    this.flex,
    this.directives = const [],
    this.dynamicProps = const [],
    this.tokens = const [],
  });

  /// Expands `DynamicAttribute` based on context
  Mixer _applyDynamicAttributes() {
    return expandAttributes((Attribute attribute) {
      /// Expands attribute if it should apply
      if (attribute is DynamicAttribute) {
        if (attribute.shouldApply(context)) {
          return attribute.attributes;
        }
      }
    });
  }

  /// Gets attributes of a `TokenAttribute` based on context
  Mixer _applyTokenAttributes() {
    return expandAttributes((Attribute attribute) {
      if (attribute is TokenRefAttribute) {
        // Get token from context and expand
        final mix = attribute.getToken(context);
        return mix.attributes;
      }
    });
  }

  Mixer expandAttributes<T extends Attribute>(AttributeGetter getter) {
    final attributes = <Attribute>[];

    for (final attr in _allAttributes) {
      attributes.addAll(getter(attr) ?? []);
    }

    if (attributes.isNotEmpty) return this;
    final mixer = Mixer.builder(context, attributes);
    return merge(mixer);
  }

  Mixer merge(Mixer other) {
    return copyWith(
      boxProps: other.box,
      textProps: other.text,
      iconProps: other.icon,
      sharedProps: other.shared,
      dynamicProps: other.dynamicProps,
      tokens: other.tokens,
      directives: other.directives,
      flexProps: other.flex,
    );
  }

  List<Attribute> get _allAttributes {
    final attributes = <Attribute>[];

    if (box != null) attributes.add(box!);
    if (text != null) attributes.add(text!);
    if (icon != null) attributes.add(icon!);
    if (shared != null) attributes.add(shared!);
    if (flex != null) attributes.add(flex!);
    if (directives.isNotEmpty) attributes.addAll(directives);
    if (dynamicProps.isNotEmpty) attributes.addAll(dynamicProps);
    if (tokens.isNotEmpty) attributes.addAll(tokens);

    return attributes;
  }

  Mixer copyWith({
    BoxAttributes? boxProps,
    TextAttributes? textProps,
    SharedAttributes? sharedProps,
    IconAttributes? iconProps,
    FlexAttributes? flexProps,
    List<DynamicAttribute> dynamicProps = const [],
    List<DirectiveAttribute> directives = const [],
    List<TokenRefAttribute> tokens = const [],
  }) {
    return Mixer._(
      context: context,
      dynamicProps: this.dynamicProps..addAll(dynamicProps),
      directives: this.directives..addAll(directives),
      tokens: this.tokens..addAll(tokens),
      box: box?.merge(boxProps) ?? boxProps,
      text: text?.merge(textProps) ?? textProps,
      shared: shared?.merge(sharedProps) ?? sharedProps,
      icon: icon?.merge(iconProps) ?? iconProps,
      flex: flex?.merge(flexProps) ?? flexProps,
    );
  }

  /// Applies all [TextDirectiveAttribute] to [text]
  String applyTextDirectives(String text) {
    final textDirectives = directives.whereType<TextDirectiveAttribute>();

    if (textDirectives.isEmpty) {
      return text;
    }

    String modifiedText = text;

    for (final attr in textDirectives) {
      modifiedText = attr.modify(modifiedText);
    }

    return modifiedText;
  }

  factory Mixer.build(BuildContext context, Mix mix) {
    return Mixer.builder(context, mix.attributes)
        ._applyTokenAttributes()
        ._applyDynamicAttributes();
  }

  factory Mixer.builder(BuildContext context, List<Attribute> attributes) {
    final allAttributes = context.mixer()?._allAttributes ?? [];
    final combined = [...allAttributes, ...attributes];
    BoxAttributes? boxAttributes;
    IconAttributes? iconAttributes;
    FlexAttributes? flexAttributes;
    SharedAttributes? sharedAttributes;
    TextAttributes? textAttributes;

    final dynamicAttributes = <DynamicAttribute>[];
    final directiveAttributes = <DirectiveAttribute>[];
    final tokenRefAttributes = <TokenRefAttribute>[];

    for (final attribute in combined) {
      if (attribute is DynamicAttribute) {
        dynamicAttributes.add(attribute);
      }

      if (attribute is DirectiveAttribute) {
        directiveAttributes.add(attribute);
      }

      if (attribute is TokenRefAttribute) {
        tokenRefAttributes.add(attribute);
      }

      if (attribute is SharedAttributes) {
        sharedAttributes ??= const SharedAttributes();
        sharedAttributes = sharedAttributes.merge(attribute);
      }

      if (attribute is TextAttributes) {
        textAttributes ??= const TextAttributes();
        textAttributes = textAttributes.merge(attribute);
      }

      if (attribute is BoxAttributes) {
        boxAttributes ??= const BoxAttributes();
        boxAttributes = boxAttributes.merge(attribute);
      }

      if (attribute is IconAttributes) {
        iconAttributes ??= const IconAttributes();
        iconAttributes = iconAttributes.merge(attribute);
      }

      if (attribute is FlexAttributes) {
        flexAttributes ??= const FlexAttributes();
        flexAttributes = flexAttributes.merge(attribute);
      }
    }

    return Mixer._(
      context: context,
      box: boxAttributes?.applyContext(context),
      text: textAttributes?.applyContext(context),
      dynamicProps: dynamicAttributes,
      shared: sharedAttributes,
      directives: directiveAttributes,
      icon: iconAttributes,
      flex: flexAttributes,
      tokens: tokenRefAttributes,
    );
  }
}