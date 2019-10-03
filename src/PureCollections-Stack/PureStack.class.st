"
I am a parametrizable stack. That is to say, I provide the interface of a stack but depending on my #strategy, I can use a LinkedList, an OrderedCollection, etc for implementation details.
"
Class {
	#name : #PureStack,
	#superclass : #Collection,
	#instVars : [
		'strategy'
	],
	#category : #'PureCollections-Stack-Base'
}

{ #category : #factory }
PureStack class >> usingLinkedList [
 	"Returns an instance of Stack using a LinkedList under the hood."
 	^ self usingStrategy: PureLinkedListStackStrategy new
]

{ #category : #factory }
PureStack class >> usingOrderedCollection [
 	"Returns an instance of Stack using a OrderedCollection under the hood."
 	^ self usingStrategy: PureOrderedCollectionStackStrategy new
]

{ #category : #'instance creation' }
PureStack class >> usingStrategy: aStackStrategy [
 	"Given a aStackStrategy, returns an instance of Stack using this strategy under the hood."
 	^ self new
 		initializeWith: aStackStrategy;
 		yourself
]

{ #category : #adding }
PureStack >> add: newObject [
 	"Include newObject as one of the receiver's elements. Answer newObject. 
 	ArrayedCollections cannot respond to this message."

  	^ self push: newObject
]

{ #category : #enumerating }
PureStack >> do: aBlock [
 	"Evaluate aBlock with each of the receiver's elements as the argument."

  	self strategy do: aBlock
]

{ #category : #initialization }
PureStack >> initialize [
	super initialize.
	strategy := PureLinkedListStackStrategy new
]

{ #category : #initialization }
PureStack >> initializeWith: aStrategy [
	strategy := aStrategy
]

{ #category : #removing }
PureStack >> pop [
	" Remove the object at the top of the stack and return it.

  	 (Stack new push: 1; push: 2; pop) >>> 2
	"
 	^ self strategy pop
]

{ #category : #adding }
PureStack >> push: newObject [
 	"Push newObject on the top of the stack."
 	self strategy push: newObject.
 	^ newObject
]

{ #category : #removing }
PureStack >> remove: oldObject ifAbsent: anExceptionBlock [
	"A stack should not implement that.
	 Use a linked list if you really need this feature.
	"
	self shouldNotImplement
]

{ #category : #removing }
PureStack >> removeAll [
	self strategy reset
]

{ #category : #accessing }
PureStack >> strategy [
	^ strategy
]

{ #category : #accessing }
PureStack >> top [
 	"Returns the object at the top of the stack without removing it."
 	^ self strategy top
]
