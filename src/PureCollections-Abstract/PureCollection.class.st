Class {
	#name : #PureCollection,
	#superclass : #Object,
	#category : #'PureCollections-Abstract'
}

{ #category : #'instance creation' }
PureCollection class >> empty [
	^ self new
]

{ #category : #testing }
PureCollection class >> isAbstract [

	^self name = #Collection
]

{ #category : #'instance creation' }
PureCollection class >> with: anObject [ 
	"Answer an instance of me containing anObject."

	^ self empty
		add: anObject;
		yourself
]

{ #category : #'instance creation' }
PureCollection class >> with: firstObject with: secondObject [ 
	"Answer an instance of me containing the two arguments as elements."

	^ self new
		add: firstObject;
		add: secondObject;
		yourself
]

{ #category : #'instance creation' }
PureCollection class >> with: firstObject with: secondObject with: thirdObject [ 
	"Answer an instance of me containing the three arguments as elements."

	^ self new
		add: firstObject;
		add: secondObject;
		add: thirdObject;
		yourself
]

{ #category : #'instance creation' }
PureCollection class >> with: firstObject with: secondObject with: thirdObject with: fourthObject [ 
	"Answer an instance of me, containing the four arguments as the elements."

	^ self new
		add: firstObject;
		add: secondObject;
		add: thirdObject;
		add: fourthObject;
		yourself
]

{ #category : #'instance creation' }
PureCollection class >> with: firstObject with: secondObject with: thirdObject with: fourthObject with: fifthObject [
	"Answer an instance of me, containing the five arguments as the elements."

	^ self new
		add: firstObject;
		add: secondObject;
		add: thirdObject;
		add: fourthObject;
		add: fifthObject;
		yourself
]

{ #category : #'instance creation' }
PureCollection class >> with: firstObject with: secondObject with: thirdObject with: fourthObject with: fifthObject with: sixthObject [
	"Answer an instance of me, containing the six arguments as the elements."

	^ self new
		add: firstObject;
		add: secondObject;
		add: thirdObject;
		add: fourthObject;
		add: fifthObject;
		add: sixthObject;
		yourself
]

{ #category : #'instance creation' }
PureCollection class >> withAll: aCollection [
	"Create a new collection containing all the elements from aCollection."

	^ (self new: aCollection size)
		addAll: aCollection;
		yourself
]

{ #category : #accessing }
PureCollection >> anyOne [
	"Answer a representative sample of the receiver. It raises an error when the collection is empty. This method can be helpful when needing to preinfer the nature of the contents of semi-homogeneous collections."
	"#(1 2 3) anyOne >>> 1"
	"
	([#() anyOne] on: SubscriptOutOfBounds do: [ :ex | 'whatever' ]) >>> 'whatever'
	"
	
	self emptyCheck.
	self do: [:each | ^ each]
]

{ #category : #printing }
PureCollection >> asCommaString [
    "Return collection printed as 'a, b, c' "
    "#( 'a' 'b' 'c') asCommaString >>> 'a, b, c'"
    
    ^String streamContents: [:s | self asStringOn: s delimiter: ', ']
]

{ #category : #printing }
PureCollection >> asCommaStringAnd [
	"Return collection printed as 'a, b and c' "
	"#( 'a' 'b' 'c') asCommaStringAnd >>> 'a, b and c'"

	^String streamContents: [:s | self asStringOn: s delimiter: ', ' last: ' and ']
]

{ #category : #printing }
PureCollection >> asStringOn: aStream delimiter: delimString [
	"Print elements on a stream separated
	with a delimiter String like: 'a, b, c'
	Uses #asString instead of #print:."

	self do: [:elem | aStream nextPutAll: elem asString]
		separatedBy: [aStream nextPutAll: delimString]
]

{ #category : #printing }
PureCollection >> asStringOn: aStream delimiter: delimString last: lastDelimString [
	"Print elements on a stream separated
	with a delimiter between all the elements and with
	a special one before the last like: 'a, b and c'.
	Uses #asString instead of #print:

	Note: Feel free to improve the code to detect the last element."

	| n sz |
	n := 1.
	sz := self size.
	self do: [:elem |
		n := n + 1.
		aStream nextPutAll: elem asString]
	separatedBy: [
		aStream nextPutAll: (n = sz ifTrue: [lastDelimString] ifFalse: [delimString])]
]

{ #category : #accessing }
PureCollection >> capacity [
	"Answer the current capacity of the receiver."

	^ self size
]

{ #category : #copying }
PureCollection >> copyEmpty [
	^ self species new
]

{ #category : #copying }
PureCollection >> copyWith: newElement [
	"Answer a new collection with newElement added (as last
	element if sequenceable)."

	^ self copy
		add: newElement;
		yourself
]

{ #category : #copying }
PureCollection >> copyWithout: oldElement [ 
	"Answer a copy of the receiver that does not contain any
	elements equal to oldElement."
	"('fred the bear' copyWithout: $e) >>> 'frd th bar'"
	"(#(2 3 4 5 5 6) copyWithout: 5) >>> #(2 3 4 6)"
	
	self flag: #TODO. "Needs to be removed probably."
	^ self reject: [:each | each = oldElement]
]

{ #category : #copying }
PureCollection >> copyWithoutAll: aCollection [
	"Answer a copy of the receiver that does not contain any elements 
	equal to those in aCollection."

	self flag: #TODO. "Needs to be removed probably."
	^ self reject: [:each | aCollection includes: each]
]

{ #category : #private }
PureCollection >> emptyCheck [

	self isEmpty ifTrue: [self errorEmptyCollection]
]

{ #category : #private }
PureCollection >> errorEmptyCollection [
	"Signal a CollectionIsEmpty exception"

	CollectionIsEmpty signalWith: self
]

{ #category : #private }
PureCollection >> errorNotFound: anObject [
	"Raise a NotFound exception."

	NotFound signalFor: anObject
]

{ #category : #private }
PureCollection >> errorSizeMismatch [
	"Signal a SizeMismatch exception"
	self flag: #TODO. "Should configure the SizeMismatch error to hold the size of mismatched collections."
	SizeMismatch signal
]

{ #category : #comparing }
PureCollection >> hash [
	"Answer an integer hash value for the receiver such that,
	  -- the hash value of an unchanged object is constant over time, and
	  -- two equal objects have equal hash values"

	| hash |

	hash := self species hash.
	self size <= 10 ifTrue:
		[self do: [:elem | hash := hash bitXor: elem hash]].
	^hash bitXor: self size hash
]

{ #category : #testing }
PureCollection >> identityIncludes: anObject [ 
	"Answer whether anObject is one of the receiver's elements."

	self do: [:each | anObject == each ifTrue: [^true]].
	^false
]

{ #category : #testing }
PureCollection >> ifEmpty: aBlock [
	"Evaluate the given block, answering its value if the receiver is empty, otherwise answer the receiver."
	
	"Note that the fact that this method returns its receiver in case the receiver is not empty allows one to write expressions like the following ones: self classifyMethodAs: (myProtocol ifEmpty: ['As yet unclassified'])"

	^ self isEmpty 
		ifTrue: [ aBlock value ]
		ifFalse: [ self ]
]

{ #category : #testing }
PureCollection >> ifEmpty: emptyBlock ifNotEmpty: notEmptyBlock [
	"Evaluate emptyBlock if I'm empty, notEmptyBlock otherwise"
	" If the notEmptyBlock has an argument, eval with the receiver as its argument"

	self isEmpty ifTrue: [ ^emptyBlock value ].
	^notEmptyBlock cull: self
]

{ #category : #testing }
PureCollection >> ifNotEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
    unless the receiver is empty, in which case answer the receiver."

    ^self isEmpty
          ifTrue: [self]
          ifFalse: [aBlock cull: self] 

]

{ #category : #testing }
PureCollection >> ifNotEmpty: notEmptyBlock ifEmpty: emptyBlock [
	"Evaluate emptyBlock if I'm empty, notEmptyBlock otherwise
	 If the notEmptyBlock has an argument, eval with the receiver as its argument"

	self isEmpty ifFalse: [ ^notEmptyBlock cull: self ].
	^emptyBlock value
]

{ #category : #testing }
PureCollection >> includes: anObject [ 
	"Answer whether anObject is one of the receiver's elements."

	^ self anySatisfy: [:each | each = anObject]
]

{ #category : #testing }
PureCollection >> includesAll: aCollection [ 
	"Answer whether all the elements of aCollection are in the receiver."
	aCollection do: [:elem | (self includes: elem) ifFalse: [^ false]].
	^ true
]

{ #category : #testing }
PureCollection >> includesAny: aCollection [ 
	"Answer whether any element of aCollection is one of the receiver's elements."
	aCollection do: [:elem | (self includes: elem) ifTrue: [^ true]].
	^ false
]

{ #category : #testing }
PureCollection >> isCollection [
	"Return true if the receiver is some sort of Collection and responds to basic collection messages such as #size and #do:"
	^true
]

{ #category : #testing }
PureCollection >> isEmpty [
	"Answer whether the receiver contains any elements."

	^self size = 0
]

{ #category : #testing }
PureCollection >> isNotEmpty [
	"Answer whether the receiver contains any elements."

	^ self isEmpty not
]

{ #category : #testing }
PureCollection >> isSequenceable [
	self flag: #TODO. "Not sure it should be here."
	^ false
]

{ #category : #printing }
PureCollection >> printElementsOn: aStream [
	"The original code used #skip:, but some streams do not support that,
	 and we don't really need it."

	aStream nextPut: $(.
	self do: [:element | aStream print: element] separatedBy: [aStream space].
	aStream nextPut: $)
]

{ #category : #printing }
PureCollection >> printNameOn: aStream [
	super printOn: aStream
]

{ #category : #printing }
PureCollection >> printOn: aStream [ 
	"Append a sequence of characters that identify the receiver to aStream."

	self printNameOn: aStream.
	self printElementsOn: aStream
]

{ #category : #printing }
PureCollection >> printOn: aStream delimiter: delimString [
	"Print elements on a stream separated
	with a delimiter String like: 'a, b, c' "

	self do: [:elem | aStream print: elem] separatedBy: [aStream nextPutAll: delimString]
		
]

{ #category : #printing }
PureCollection >> printOn: aStream delimiter: delimString last: lastDelimString [
	"Print elements on a stream separated
	with a delimiter between all the elements and with
	a special one before the last like: 'a, b and c'

	Note: Feel free to improve the code to detect the last element."

	| n sz |
	n := 1.
	sz := self size.
	self do: [:elem |
		n := n + 1.
		aStream print: elem]
	separatedBy: [
		n = sz
			ifTrue: [aStream print: lastDelimString]
			ifFalse: [aStream print: delimString]]
]

{ #category : #accessing }
PureCollection >> size [
	"Answer how many elements the receiver contains."
	^ self subclassResponsibility
]

{ #category : #printing }
PureCollection >> storeOn: aStream [ 
	"Refer to the comment in Object|storeOn:."

	| noneYet |
	aStream nextPutAll: '(('.
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' new)'.
	noneYet := true.
	self do: 
		[:each | 
		noneYet
			ifTrue: [noneYet := false]
			ifFalse: [aStream nextPut: $;].
		aStream nextPutAll: ' add: '.
		aStream store: each].
	noneYet ifFalse: [aStream nextPutAll: '; yourself'].
	aStream nextPut: $)
]
