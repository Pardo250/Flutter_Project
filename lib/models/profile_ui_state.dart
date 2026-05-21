import 'package:flutter/material.dart';
import '../models/articulo.dart';
import '../models/review.dart';

class ProfileUiState {
  final String name;
  final String username;
  final String? imageUrl;
  final int followersCount;
  final int followingCount;
  final bool isTopReviewer;
  final bool isInfluencer;
  final List<Review> reviews;
  final List<Articulo> savedArticles;
  final bool isLoading;
  final String? errorMessage;
  final bool isShowingSaved;
  final bool isEditingReview;
  final String editComment;
  final int editRating;

  ProfileUiState({
    this.name = '',
    this.username = '',
    this.imageUrl,
    this.followersCount = 0,
    this.followingCount = 0,
    this.isTopReviewer = false,
    this.isInfluencer = false,
    this.reviews = const [],
    this.savedArticles = const [],
    this.isLoading = false,
    this.errorMessage,
    this.isShowingSaved = false,
    this.isEditingReview = false,
    this.editComment = '',
    this.editRating = 5,
  });

  ProfileUiState copyWith({
    String? name,
    String? username,
    String? imageUrl,
    int? followersCount,
    int? followingCount,
    bool? isTopReviewer,
    bool? isInfluencer,
    List<Review>? reviews,
    List<Articulo>? savedArticles,
    bool? isLoading,
    String? errorMessage,
    bool? isShowingSaved,
    bool? isEditingReview,
    String? editComment,
    int? editRating,
  }) {
    return ProfileUiState(
      name: name ?? this.name,
      username: username ?? this.username,
      imageUrl: imageUrl ?? this.imageUrl,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      isTopReviewer: isTopReviewer ?? this.isTopReviewer,
      isInfluencer: isInfluencer ?? this.isInfluencer,
      reviews: reviews ?? this.reviews,
      savedArticles: savedArticles ?? this.savedArticles,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isShowingSaved: isShowingSaved ?? this.isShowingSaved,
      isEditingReview: isEditingReview ?? this.isEditingReview,
      editComment: editComment ?? this.editComment,
      editRating: editRating ?? this.editRating,
    );
  }
}
