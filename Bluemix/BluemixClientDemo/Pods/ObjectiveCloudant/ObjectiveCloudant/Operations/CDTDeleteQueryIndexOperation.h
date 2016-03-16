//
//  CDTDeleteQueryIndexOperation.h
//  ObjectiveCloudant
//
//  Created by Rhys Short on 05/10/2015.
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
 An Operation to delete query indexes from a database.
 */
@interface CDTDeleteQueryIndexOperation : CDTCouchDatabaseOperation

/**
 * The name of the design doc that contains the index to be deleted
 *
 * Required: Needs to be set before an operation is executed.
 **/
@property (nullable, nonatomic, strong) NSString* designDocName;

/**
 * The type of index that is to be deleted, defaults to CDTQueryIndexTypeJson
 **/
@property (nonatomic) CDTQueryIndexType indexType;

/**
 * The name of the index to be deleted
 *
 * Required: Needs to be set before an operation is executed.
 **/
@property (nullable, nonatomic, strong) NSString* indexName;

/**
 Completion block to run when the operation completes.

 - statusCode - The status code of HTTP response, if the request
 hasn't been successfully made this will equal kCDTNoHTTPStatus
 - operationError - a pointer to an error object containing
 information about an error executing the operation
 */
@property (nullable, nonatomic, copy) void (^deleteIndexCompletionBlock)
    (NSInteger statusCode, NSError* _Nullable operationError);

@end
