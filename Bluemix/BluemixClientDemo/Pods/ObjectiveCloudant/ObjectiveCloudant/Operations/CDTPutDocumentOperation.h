//
//  CDTPutDocumentOperation.h
//  ObjectiveCloudant
//
//  Created by Michael Rhodes on 16/09/2015.
//  Copyright (c) 2015 IBM Corp.
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file
//  except in compliance with the License. You may obtain a copy of the License at
//    http://www.apache.org/licenses/LICENSE-2.0
//  Unless required by applicable law or agreed to in writing, software distributed under the
//  License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
//  either express or implied. See the License for the specific language governing permissions
//  and limitations under the License.

#import <ObjectiveCloudant/ObjectiveCloudant.h>

/**
 An operation to create or update a document in a database.
 */
@interface CDTPutDocumentOperation : CDTCouchDatabaseOperation

/**
 The document that this operation will modify.

 Must be set before a call can be successfully made.
 */
@property (nullable, nonatomic, strong) NSString *docId;

/**
 If updating a document, set this value to the current revision ID.
 */
@property (nullable, nonatomic, strong) NSString *revId;

/** Body of document. Must be serialisable with NSJSONSerialization */
@property (nullable, nonatomic, strong) NSObject *body;

/**
 Completion block to run when the operation completes.

 - docId - the id of the document written to the database
 - revId - the revision of the document written to the database
 - operationError - a pointer to an error object containing
 information about an error executing the operation
 */
@property (nonnull, nonatomic, copy) void (^putDocumentCompletionBlock)
    (NSString *_Nullable docId, NSString *_Nullable revId, NSInteger statusCode,
     NSError *_Nullable operationError);

@end
