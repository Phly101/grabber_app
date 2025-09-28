

import "dart:io";

import "package:equatable/equatable.dart";



sealed class InvoiceState extends Equatable {
  const InvoiceState();

  @override
  List<Object?> get props => [];
}

class InvoiceInitial extends InvoiceState {}

class InvoiceLoading extends InvoiceState {}

class InvoiceGenerated extends InvoiceState {
  final File file;

  const InvoiceGenerated(this.file);

  @override
  List<Object?> get props => [file];
}

class InvoiceError extends InvoiceState {
  final String message;

  const InvoiceError(this.message);

  @override
  List<Object?> get props => [message];
}

