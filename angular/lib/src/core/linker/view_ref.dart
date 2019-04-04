import 'dart:html';

abstract class ViewRef {
  bool get destroyed;

  void onDestroy(void Function() callback);
}

/// Represents an Angular View.
///
/// A View is a fundamental building block of the application UI. It is the
/// smallest grouping of Elements which are created and destroyed together.
///
/// Properties of elements in a View can change, but the structure (number
/// and order) of elements in a View cannot. Changing the structure of Elements
/// can only be done by inserting, moving or removing nested Views via a
/// [ViewContainerRef]. Each View can contain many View Containers.
///
/// ### Example
///
/// Given this template...
///
///     Count: {{items.length}}
///     <ul>
///       <li///ngFor="let  item of items">{{item}}</li>
///     </ul>
///
///     ... we have two [EmbeddedViewRef]s:
///
///     Outer [EmbeddedViewRef]:
///     Count: {{items.length}}
///     <ul>
///       <template ngFor let-item [ngForOf]="items"></template>
///     </ul>
///
///     Inner [EmbeddedViewRef]:
///       <li>{{item}}</li>
///
/// Notice that the original template is broken down into two separate
/// [EmbeddedViewRef]s.
///
/// The outer/inner [EmbeddedViewRef]s are then assembled into views like so:
///
/// <!-- ViewRef: outer-0 -->
/// Count: 2
/// <ul>
///   <template view-container-ref></template>
///   <!-- ViewRef: inner-1 --><li>first</li><!-- /ViewRef: inner-1 -->
///   <!-- ViewRef: inner-2 --><li>second</li><!-- /ViewRef: inner-2 -->
/// </ul>
/// <!-- /ViewRef: outer-0 -->
///
abstract class EmbeddedViewRef extends ViewRef {
  /// Sets [value] of local variable called [variableName] in this View.
  void setLocal(String variableName, dynamic value);

  /// Checks whether this view has a local variable called [variableName].
  bool hasLocal(String variableName);

  List<Node> get rootNodes;

  /// Detaches the view and destroys all of its associated state.
  void destroy();

  /// Marks the node for change detection.
  void markForCheck();
}
