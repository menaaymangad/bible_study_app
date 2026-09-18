import 'package:flutter/material.dart';

/// A reusable card container for app content.
class BookCard extends StatelessWidget {
	const BookCard({
		required this.child,
		super.key,
		this.onTap,
		this.padding = const EdgeInsets.all(16),
		this.margin = EdgeInsets.zero,
		this.color,
		this.borderRadius = const BorderRadius.all(Radius.circular(12)),
		this.elevation = 0,
		this.border,
	});

	final Widget child;
	final VoidCallback? onTap;
	final EdgeInsetsGeometry padding;
	final EdgeInsetsGeometry margin;
	final Color? color;
	final BorderRadius borderRadius;
	final double elevation;
	final BorderSide? border;

	@override
	Widget build(BuildContext context) {
		return Card(
			margin: margin,
			color: color,
			elevation: 0,
			clipBehavior: Clip.antiAlias,
			shape: RoundedRectangleBorder(
				borderRadius: borderRadius,
				side: border ?? BorderSide.none,
			),
			child: InkWell(
				onTap: onTap,
				child: Padding(padding: padding, child: child),
			),
		);
	}
}
