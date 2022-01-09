Class {
	#name : #TBScreenComponent,
	#superclass : #WAComponent,
	#instVars : [
		'header'
	],
	#category : #'TinyBlog-Components'
}

{ #category : #accessing }
TBScreenComponent >> blog [
	^ TBBlog current
]

{ #category : #rendering }
TBScreenComponent >> children [ 
	^ { header }
]

{ #category : #rendering }
TBScreenComponent >> createHeaderComponent [
	^ TBHeaderComponent from: self
]

{ #category : #private }
TBScreenComponent >> initialize [ 
	super initialize.
	header := self createHeaderComponent
]

{ #category : #rendering }
TBScreenComponent >> renderContentOn: html [
	html render: header
]

{ #category : #rendering }
TBScreenComponent >> rendererClass [ 
   ^ SBSHtmlCanvas 
]
