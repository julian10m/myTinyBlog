Class {
	#name : #TBBlogTest,
	#superclass : #TestCase,
	#instVars : [
		'blog',
		'post',
		'first',
		'previousRepository'
	],
	#category : #'TinyBlog-Tests'
}

{ #category : #running }
TBBlogTest >> setUp [ 
	previousRepository := VORepository current.
	VORepository setRepository: VOMemoryRepository new.
	blog := TBBlog current.

	first := TBPost title: 'a title' text: 'A text' category: 'First Category'.
	blog writeBlogPost: first.	
	post := (TBPost title: 'Another title' text: 'Another text' category: 'Second Category') beVisible.
]

{ #category : #running }
TBBlogTest >> tearDown [ 
	VORepository setRepository: previousRepository 
]

{ #category : #initialization }
TBBlogTest >> testAddBlogPost [
	blog writeBlogPost: post.
	self assert: blog size equals: 2.
]

{ #category : #initialization }
TBBlogTest >> testAllBlogPosts [
	blog writeBlogPost: post.
	self assert: blog allBlogPosts size equals: 2
]

{ #category : #initialization }
TBBlogTest >> testAllBlogPostsFromCategory [
	self assert: (blog allBlogPostsFromCategory: 'First Category') size equals: 1
]

{ #category : #initialization }
TBBlogTest >> testAllCategories [
	blog writeBlogPost: post.
	self assert: blog allCategories size equals: 2
]

{ #category : #initialization }
TBBlogTest >> testAllVisibleBlogPosts [
	blog writeBlogPost: post.
	self assert: blog allVisibleBlogPosts size equals: 1
]

{ #category : #initialization }
TBBlogTest >> testAllVisibleBlogPostsFromCategory [
	blog writeBlogPost: post.
	self 
		assert: (blog allVisibleBlogPostsFromCategory: 'First Category') size equals: 0;
		assert: (blog allVisibleBlogPostsFromCategory: 'Second Category') size equals: 1.
		
]

{ #category : #initialization }
TBBlogTest >> testCategoriesWithPosts [
	blog writeBlogPost: post.
	self assert: blog categoriesWithVisiblePosts size equals: 1
]

{ #category : #initialization }
TBBlogTest >> testDeleteCategoryAndItsPosts [
	blog deletePostsForCategory: 'First Category'.
	self
		assert: blog allCategories size equals: 0; 
		assert: blog allVisibleBlogPosts size equals: 0
]

{ #category : #initialization }
TBBlogTest >> testDisplayCategory [
	self assert: (blog allVisibleBlogPostsFromCategory: 'First Category') size equals: 0.
	blog displayCategory: 'First Category'.
	self assert: (blog allVisibleBlogPostsFromCategory: 'First Category') size equals: 1.
]

{ #category : #initialization }
TBBlogTest >> testHideCategory [
	blog writeBlogPost: post.
	blog hideCategory: 'First Category'.
	self assert: (blog allVisibleBlogPostsFromCategory: 'First Category') size equals: 0.
]

{ #category : #initialization }
TBBlogTest >> testRemoveAllBlogPosts [
	blog removeAllPosts.
	self assert: blog size equals: 0
]

{ #category : #initialization }
TBBlogTest >> testRenameCategory [
	blog writeBlogPost: post.
	blog renameCategory: 'Second Category' toBe: 'First Category'.
	self assert: blog allCategories size equals: 1.
	self assert: (blog allBlogPostsFromCategory: 'First Category') size equals: 2
]

{ #category : #initialization }
TBBlogTest >> testSize [
	self assert: blog size equals: 1
]

{ #category : #initialization }
TBBlogTest >> testUnclassifiedBlogPosts [

	self assert: (blog allBlogPosts allSatisfy: [ :e | 
			 e category ~= e class unclassifiedTag ])
]
