/**
 * Created by John Hall on 5/21/15
 * Contributions from John Campbell on 6/23/15
 * Copyright (c) 2015 Maponics. All rights reserved.
 */
'use strict';

/** @ignore */
var Debugger = require('../modules/debugger'),
	fs = require('fs'),
	config = (fs.existsSync('../modules/config.json'))? 
				require('../modules/config.json') : 
				require('../modules/config'),
	pg = require('pg'),
	turf = require('turf'),
	WKT = require('terraformer-wkt-parser'),
	nodemailer = require('nodemailer'),
	smtpTransport = require('nodemailer-smtp-transport'),
	AWS = require("aws-sdk"),
	s3 = new AWS.S3,
	Q = require("q");

pg.summaryError = function (error, res, sql) {
	Debugger.on = true;
	Debugger.log( 'ERROR!' );
	Debugger.log( (error.stack || error) + '\n' + sql);
	res.status(500).send({'Error': (error.stack || error)});
	return true;
};

/** 
 * @class Summary
 */
function Summary() {
	Debugger.on = true;
	
	/* STATIC => class constants, fields & functions */
	/** @ignore */
	var req, res,
		page = 0,
		summaryData = {};

	if( typeof arguments[0] !== 'object' )
		return null;

	else if( typeof arguments[0].get === 'function' ) {
		/* Called as route handler */
		req = arguments[0];
		res = arguments[1];
		summaryData = req.body || arguments[2];

		/* Query parameter for getAllSummaries() & getSummaryByOrganization() methods */
		page = req.query.page || 0;

		Debugger.log({
			'req.ip (Client)': 				req.ip,
			'req.hostname (Host)':			req.hostname,
			'req.baseUrl (Class)': 			req.baseUrl,
			'req.path (Method)':			req.path,
			'req.query (Query Args)':		req.query,
			'req.body (Data)':				req.body,
			'req.fields (Form Vals)':		req.fields,
			'req.files (Uploads)':			req.files
		}, '\n\nRequesting Summary with this request object:\n $1');
		
	} else
		summaryData = arguments[0];

	Summary.notify = function (email, subject, message) {
        var message = message + '<br /><br />\
<strong>Data For Life®</strong> – Maponics defines and characterizes real-life geographies in the communities where people live, work and play. Products include Neighborhoods, Residential Boundaries, Schools, Social Places, ZIP Code Boundaries and more, as well as Context® data that helps define local character. We solve display, search and analytic challenges faced by real estate, local search, mobile marketing and other industries. Learn how we can help you at <a href="http://maponics.com">maponics.com</a> or call us at <a href="tel:18007625158">1-800-762-5158</a>.<br />\
<br />\
Legal Items: © 2015. This email and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. Any pricing information, product samples, or customer specifications contained in this message are considered privileged, confidential and protected from disclosure and/or forwarding to others outside your organization. If you have received this communication in error, please notify Maponics immediately by replying to the sender named above and deleting this message from your computer.<br />\
<br />\
<strong>Maponics, LLC | 35 Railroad Row, White River Junction, Vermont 05001, United States</strong>';
        
		nodemailer.createTransport({
			host: 'smtp.office365.com',
			port: 587,
			auth: {
				user: 'crowd@maponics.com',
				pass: 'Feedback1234'
			}
		}).sendMail(
			{
				from: 'Maponics Feedback <crowd@maponics.com>',
				to: email,
				subject: subject,
				html: message
			},
			function (error) {
				Debugger.on = true;

				try {
					if (error) {
						Debugger.log(error);
						return false;
					} else
						return true;

				} catch (e) {
					Debugger.log(e.stack);
					return false;
				}
			}
		);

		return true;
	};

	Summary.notifyManager = function (req, summaryList) {
		pg.connect(req.connection, function (error, client, done) {
			var sql =
				'SELECT ' +
					'id, ' +
					'email ' +
				'FROM ' + config[req.hostname].manager.schema + '."' + config[req.hostname].manager.table + '" ' +
//				'WHERE id = 2' +
				'ORDER BY id;';

			if (error)
				pg.summaryError(error, res, sql);

			else
				client.query(sql, function (error, result) {
					if (error)
						pg.summaryError(error, res, sql);

					else if (result.rowCount > 0) {
						var emailList = [],
							interval = parseInt(req.query.days),
							message = '',
							subject = 'Maponics Feedback Resource Summary Modifications';

						result.rows.forEach(function (row) {
							emailList.push(row.email);
							return true;
						});

						if (interval == 0)
							message = 'The following ' + summaryList.length + ' Resource Summaries were modified today:';
						else if (interval == 1)
							message = 'The following ' + summaryList.length + ' Resource Summaries were modified in the past 24 hours:';
						else if (interval > 1)
							message = 'The following ' + summaryList.length + ' Resource Summaries were modified in the past ' + interval + ' days:';

						message +=
							'<br><br>' +
							'<table style="border: 1px solid; width:100%;">' +
							'<tr>' +
							'<th style="border-bottom: 2px solid;">RID</th>' +
							'<th style="border-bottom: 2px solid;">CID</th>' +
							'<th style="border-bottom: 2px solid;">Contact Name</th>' +
							'<th style="border-bottom: 2px solid;">Organization</th>' +
							'<th style="border-bottom: 2px solid;">Created</th>' +
							'<th style="border-bottom: 2px solid;">Modified</th>' +
							'<th style="border-bottom: 2px solid;">Status</th>' +
							'<th style="border-bottom: 2px solid;">Feature Type</th>' +
							'<th style="border-bottom: 2px solid;">JSON Type</th>' +
							'<th style="border-bottom: 2px solid;">Feature Name</th>' +
							'<th style="border-bottom: 2px solid;">Feedback Summary</th>' +
							'<th style="border-bottom: 2px solid;"># Attach</th>' +
							'</tr>';

						if (summaryList.length > 0) {
							var cidList = [];

							summaryList.forEach(function (summary) {
								if (cidList.indexOf(summary.cid) === -1)
									cidList.push(summary.cid);

								return true;
							});

							pg.connect(req.connection, function (error, client, done) {
								var sql =
									'SELECT ' +
										'c.cid, ' +
										'c.first_name, ' +
										'c.last_name, ' +
										'o.name AS organization ' +
									'FROM ' +
										config[req.hostname].contact.schema + '."' + config[req.hostname].contact.table + '" c, ' +
										config[req.hostname].organization.schema + '."' + config[req.hostname].organization.table + '" o ' +
									'WHERE c.cid IN (' + cidList.toString() + ') ' +
										'AND c.organization = o.id ' +
									'ORDER BY c.cid;';

								if (error)
									pg.summaryError(error, res, sql);

								else
									client.query(sql, function (error, result) {
										if (error)
											pg.summaryError(error, res, sql);

										else if (result.rowCount > 0) {
											summaryList.forEach(function (summary) {
												if (summary.featurename == null)
													summary.featurename = 'Missing Feature';

												result.rows.forEach(function (row) {
													if (summary.cid === row.cid) {
														summary.contactName = row.first_name + ' ' + row.last_name;
														summary.organization = row.organization;
													}

													return true;
												});

												return true;
											});

											summaryList.forEach(function (summary) {
												var attachCount = 0;

												if (summary.attachments)
													attachCount = summary.attachments.length;

												message +=
													'<tr>' +
													'<td style="text-align: center;">' + summary.rid + '</td>' +
													'<td style="text-align: center;">' + summary.cid + '</td>' +
													'<td style="text-align: center;">' + summary.contactName + '</td>' +
													'<td style="text-align: center;">' + summary.organization + '</td>' +
													'<td style="text-align: center;">' + new Date(summary.created * 1000).toString().slice(4, 15) + '</td>' +
													'<td style="text-align: center;">' + new Date(summary.modified * 1000).toString().slice(4, 15) + '</td>' +
													'<td style="text-align: center;">' + summary.status + '</td>' +
													'<td style="text-align: center;">' + summary.featuretype + '</td>' +
													'<td style="text-align: center;">' + summary.type + '</td>' +
													'<td style="text-align: center;">' + summary.featurename + '</td>' +
													'<td style="text-align: center;">' + summary.feedbacksummary + '</td>' +
													'<td style="text-align: center;">' + attachCount + '</td>' +
													'</tr>';

												return true;
											});

											message += '</table>';
											Summary.notify(emailList.join('; '), subject, message);

										} else if (result.rowCount == 0) {
											Debugger.on = true;
											Debugger.log('No rows received for: \n' + sql);
										}

										return done();
									});

								return true;
							});

						} else {
							message += '</table>';
							Summary.notify(emailList.join('; '), subject, message);
						}

					} else if (result.rowCount == 0) {
						Debugger.on = true;
						Debugger.log('No rows received for: \n' + sql);
					}

					return done();
				});

			return true;
		});

		return true;
	};

	Summary.notifyStatus = function (req, summaryList) {
		pg.connect(req.connection, function (error, client, done) {
			var sql =
				'SELECT ' +
					'first_name, ' +
					'email ' +
				'FROM ' + config[req.hostname].contact.schema + '."' + config[req.hostname].contact.table + '" ' +
				'WHERE cid = $1;';

			if (error)
				pg.summaryError(error, res, sql);

			else
				client.query(sql, [summaryList[0].cid], function (error, result) {
					if (error)
						pg.summaryError(error, res, sql);

					else if (result.rowCount > 0) {
						var email = result.rows[0].email,
							subject = 'Your Maponics Feedback Status has been Updated',
							message = 'Dear ' + result.rows[0].first_name + ',' + '<br><br>' +
									  'Please be advised that the feedback status of Resource Summary ID #' + summaryList[0].rid +
									  ' "' + summaryList[0].feedbacksummary + '" ' +
									  'has been changed today from the existing status of "' + req.oldStatus + '" ' +
									  'to the updated status of "' + summaryList[0].status + '".';

						if (summaryList[0].status !== 'Rejected')
							message += ' No further action is required at this time.' + '<br><br>';
						else if (summaryList[0].status === 'Rejected' && req.query.note !== undefined)
							message += '<br><br>' + 'Additional Notes:' + '<br>' + req.query.note + '<br><br>';
						else
							message += '<br><br>';

						message += 'Thank you,' + '<br>' +
								   'The Maponics Feedback Team';

						Summary.notify(email, subject, message);

					} else if (result.rowCount == 0) {
						Debugger.on = true;
						Debugger.log('No rows received for: \n' + sql);
					}

					return done();
				});

			return true;
		});

		return true;
	};

	Summary.query = function (req, res, client, done, sql, param) {
		if (param === undefined)
			client.query(sql, function (error, result) {
				Summary.queryResult(req, res, error, result, sql);
			});

		else
			client.query(sql, param, function (error, result) {
				Summary.queryResult(req, res, error, result, sql);
			});

		return done();
	};

	Summary.queryResult = function (req, res, error, result, sql) {
		var summaryList = [];

		if (error)
			pg.summaryError(error, res, sql);

		else if (result.rowCount > 0) {
			if (parseInt(page) !== parseInt(page) || parseInt(page) < 1)
				page = 0;

			var i = ( page > 0 ) ? (page - 1) * 100 : 0,
				p = ( page > 0 ) ? (page) * 100 : result.rowCount;

			for (; i < p && i < result.rowCount; i++) {
				var summaryData = ( 'rid' in result.rows[i] ) ? result.rows[i] : false,
					summaryObject = new Summary(summaryData);

				for (var prop in summaryObject) {
					if (typeof summaryObject[prop] === 'string') {
						summaryObject[prop] = summaryObject[prop]
							.replace(/\&apos\;/g, "'")
							.replace(/\&quot\;/g, "'");
					}
				}
				
				var parseJSONProp = function( jsonprop ) {
					var parsed;

					try {
						parsed = (typeof summaryObject[jsonprop] !== 'object') ?
							JSON.parse(summaryObject[jsonprop]) : summaryObject[jsonprop];

					} catch (error) {
						parsed = {'Error': 'Could not parse json: ' + error.stack};

					} finally {
						if (parsed)
							summaryObject[jsonprop] = parsed;
						else
							delete summaryObject[jsonprop];
					}
				};
				
				if( summaryObject.json ) parseJSONProp('json');
				if( summaryObject.geom ) parseJSONProp('geom');
				if( summaryObject.clientinternaljson ) parseJSONProp('clientinternaljson');
				if( summaryObject.attachments ) parseJSONProp('attachments');

				summaryList.push(summaryObject);
			}
			
			if( Summary.hidePromise && Summary.hide !== null ) {
				
				Summary.hidePromise.then(function( resolved ) {
					/* Promise resolved is something like...
					 * [{
					 *   "rid":13,
					 *   "idx":1,
					 *	 "attachment":{
					 *	   "id":"speed_test.b57c9dba1fb2fcca153c94dcd2eee2ec.png",
					 *	   "type":"S3",
					 *	   "url":"https://s3.amazonaws.com/feedbackplatformattachments/fromwebapp/13/speed_test.png",
					 *	   "auth":"",
					 *	   "contact":"1149",
					 *	   "modified":"1447440976",
					 *	   "hidden":"false"
					 *   }
					 * }, ...
					 * ]
					 */
					Debugger.log( resolved, "Attachments to be hidden:\n$1" );
					
					summaryList.forEach(function( s ) {
						if( resolved.length > 0 ) try { 
							resolved.forEach(function( a ) {
								var i = a.idx - 1;
								
								//Debugger.log( a, "resolved.forEach... a: $1" );
								//Debugger.log( s, "resolved.forEach... s: $1" );
								Debugger.log( "Current file index: "+ i);
								Debugger.log( s.attachments[i], "resolved.forEach... attachment: $1" );

								if( s.attachments[i].id === a.attachment.id ) {
									s.attachments[i].hidden = true;
								}
								/* This next part is kind of wierd, but PostgreSQL
								 * indexes arrays starting at 1, not 0
								 */
								s['attachments['+ a.idx +']'] = s.attachments[i];
								Debugger.log( s['attachments['+ a.idx +']'], "Attachment "+ a.idx +":\n $1" );

								return a;
							});
							
							/* Cannot UPDATE attachments directly because
							 * it's an SQL array type. Must update individual
							 * array elements, hence s['attachments['+ a.idx +']'] = ...
							 */
							delete s.attachments;
							s.update(req, res);
							
						} catch(e) { 
							Debugger.log( e.stack );
						}
						
						return s;
					});
					
					return true;
					
				}, function( rejected ) {
					Debugger.log( rejected, "Hide promise was rejected:\n$1" );
					return true;
				});
				
				/* Prevent infinite loop */				
				Summary.hide = null;	
				
			} else if( typeof req.callback === 'function' ) {
				req.callback(summaryList);

			} else if( req.files && req.files.data && (req.files.data['size'] > 0)) {
				summaryList.forEach(function( s ) {
					s.attachFile(req, res);
					return s;
				});
				
			} else {
				res.status(200).send(summaryList);

				if (req.notify) {
					if (req.notify == 'manager')
						Summary.notifyManager(req, summaryList);
					else if (req.notify == 'status')
						Summary.notifyStatus(req, summaryList);
				}
			}

		} else if (result.rowCount == 0) {
			Debugger.on = true;
			Debugger.log('No rows received for: \n' + sql);

			if (typeof req.callback === 'function')
				req.callback([]);

			else {
				res.status(200).send([]);

				if (req.notify == 'manager')
					Summary.notifyManager(req, summaryList);
			}
		}

		return true;
	};

	/**
	 * Request Summary data dictionary
	 *
	 * @param {string} apikey Unique Identifier for software developer accessing the Maponics Feedback API
	 * @returns {Array} Array of Summary data dictionary objects including enumerated values
	 * @memberOf Summary
	 * @example
	 *        {HOST}/resource/getDataDictionary?apikey=051404be-5e60-4407-b1cf-fb92098ff98e
	 *
	 */
	function getDataDictionary( req, res ) {
		pg.connect(req.connection, function (error, client, done) {
			var sql =
				'SELECT ' +
					'enum_range(NULL::feedbacktype_enum) AS feedbacktype_enum, ' +
					'enum_range(NULL::featuretype_enum) AS featuretype_enum, ' +
					'enum_range(NULL::status_enum) AS status_enum ' +
				'FROM ' + config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" ' +
				'LIMIT 1;';

			if (error)
				pg.summaryError(error, res, sql);
			else
				client.query(sql, function (error, result) {
					if (error)
						pg.summaryError(error, res, sql);

					else if (result.rowCount > 0) {
						pg.connect(req.connection, function (error, client, done) {
							var featureTypeEnum = result.rows[0].featuretype_enum
									.substring(1, result.rows[0].featuretype_enum.length - 1)
									.replace(/"/g, '')
									.split(','),
								feedbackTypeEnum = result.rows[0].feedbacktype_enum
									.substring(1, result.rows[0].feedbacktype_enum.length - 1)
									.replace(/"/g, '')
									.split(','),
								statusEnum = result.rows[0].status_enum
									.substring(1, result.rows[0].status_enum.length - 1)
									.replace(/"/g, '')
									.split(','),
								sql =
									'SELECT ' +
										'column_name, ' +
										'data_type ' +
									'FROM information_schema.columns ' +
									'WHERE table_schema = $1 ' +
										'AND table_name = $2;';

							if (error)
								pg.summaryError(error, res, sql);

							else
								client.query(sql, [config[req.hostname].resource.schema, config[req.hostname].resource.table], function (error, result) {
									if (error)
										pg.summaryError(error, res, sql);

									else if (result.rowCount > 0) {
										for (var i = 0; i < result.rowCount; i++) {
											if (result.rows[i].column_name == 'featuretype') {
												result.rows[i].data_type = 'featuretype_enum';
												result.rows[i].enum_values = featureTypeEnum;

											} else if (result.rows[i].column_name == 'feedbacktype') {
												result.rows[i].data_type = 'feedbacktype_enum';
												result.rows[i].enum_values = feedbackTypeEnum;

											} else if (result.rows[i].column_name == 'status') {
												result.rows[i].data_type = 'status_enum';
												result.rows[i].enum_values = statusEnum;

											} else if (result.rows[i].column_name == 'attachments') {
												result.rows[i].data_type = 'json[]';
												result.rows[i].json_properties = config.attachments;

											} else if (result.rows[i].column_name == 'geom') {
												result.rows[i].data_type = 'json';
											}
										}

										res.status(200).send(result.rows);

									} else if (result.rowCount == 0) {
										Debugger.on = true;
										Debugger.log('No rows received for: \n' + sql);
										res.status(200).send([]);
									}

									return done();
								});

							return true;
						});

					} else if (result.rowCount == 0) {
						Debugger.on = true;
						Debugger.log('No rows received for: \n' + sql);
						res.status(200).send([]);
					}

					return done();
				});

			return true;
		});

		return true;
	}

	/**
	 * GET an array of resource Summary objects representing all saved resources.
	 * <em>Optional:</em> For large results sets the page parameter specifies which
	 * factor of 100 Contact  objects should be included (i.e. for a results set of
	 * 300 or more objects, page=3 will return an array containing the 201st to the
	 * 300th object)
	 *
	 * @param {string} apikey Unique Identifier for software developer accessing the Maponics Feedback API
	 * @param {Number} page* <em>Optional</em> paging factor
	 * @returns {Array} Array of Summary objects
	 * @memberOf Summary
	 * @example
	 *        {HOST}/resource/getAllSummaries?page=1&apikey=051404be-5e60-4407-b1cf-fb92098ff98e
	 *
	 */
	function getAllSummaries(req, res) {
		pg.connect(req.connection, function (error, client, done) {
			var sql = '';

			if (req.query.organization == 1)
				sql =
					'SELECT ' +
						'rid, ' +
						'cid, ' +
						'type, ' +
						'zipped, ' +
						'DATE_PART(\'epoch\', created) AS created, ' +
						'DATE_PART(\'epoch\', modified) AS modified, ' +
						'status, ' +
						'feedbacksummary, ' +
						'feedbacktype, ' +
						'featureid, ' +
						'featurename, ' +
						'featuretype, ' +
						'clientinternaljson, ' +
						'json, ' +
						'ST_AsGeoJSON(geom, 6) AS geom, ' +
						'attachments, ' +
						'deleted ' +
					'FROM ' + config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" ' +
					'ORDER BY rid;';
			else
				sql =
					'SELECT ' +
						'r.rid, ' +
						'r.cid, ' +
						'c.organization, ' +
						'r.type, ' +
						'r.zipped, ' +
						'DATE_PART(\'epoch\', r.created) AS created, ' +
						'DATE_PART(\'epoch\', r.modified) AS modified, ' +
						'r.status, ' +
						'r.feedbacksummary, ' +
						'r.feedbacktype, ' +
						'r.featureid, ' +
						'r.featurename, ' +
						'r.featuretype, ' +
						'r.clientinternaljson, ' +
						'r.json, ' +
						'ST_AsGeoJSON(geom, 6) AS geom, ' +
						'r.attachments, ' +
						'r.deleted ' +
					'FROM ' +
						config[req.hostname].contact.schema + '."' + config[req.hostname].contact.table + '" c, ' +
						config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" r ' +
					'WHERE c.organization = ' + req.query.organization + ' ' +
						'AND c.cid = r.cid ' +
					'ORDER BY r.rid;';

			if (error)
				pg.summaryError(error, res, sql);
			else
				Summary.query(req, res, client, done, sql);

			return true;
		});

		return true;
	}

	/**
	 * GET an array of resource Summary objects selected by the organization ID associated with a specified apikey
	 * <em>Optional:</em> For large results sets the page parameter specifies which
	 * factor of 100 Contact  objects should be included (i.e. for a results set of
	 * 300 or more objects, page=3 will return an array containing the 201st to the
	 * 300th object)
	 *
	 * @param {string} apikey Unique Identifier for software developer accessing the Maponics Feedback API
	 * @param {Number} page* <em>Optional</em> paging factor
	 * @returns {Array} Array of Summary objects
	 * @memberOf Summary
	 * @example
	 *        {HOST}/resource/getSummaryByOrganization?page=1&apikey=051404be-5e60-4407-b1cf-fb92098ff98e
	 *
	 */
	function getSummaryByOrganization(req, res) {
		pg.connect(req.connection, function (error, client, done) {
			var sql =
				'SELECT ' +
					'r.rid, ' +
					'r.cid, ' +
					'c.organization, ' +
					'r.type, ' +
					'r.zipped, ' +
					'DATE_PART(\'epoch\', r.created) AS created, ' +
					'DATE_PART(\'epoch\', r.modified) AS modified, ' +
					'r.status, ' +
					'r.feedbacksummary, ' +
					'r.feedbacktype, ' +
					'r.featureid, ' +
					'r.featurename, ' +
					'r.featuretype, ' +
					'r.clientinternaljson, ' +
					'r.json, ' +
					'ST_AsGeoJSON(geom, 6) AS geom, ' +
					'r.attachments, ' +
					'r.deleted ' +
				'FROM ' +
					config[req.hostname].contact.schema + '."' + config[req.hostname].contact.table + '" c, ' +
					config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" r ' +
				'WHERE c.organization = ' + req.query.organization + ' ' +
					'AND c.cid = r.cid ' +
				'ORDER BY r.rid;';

			if (error)
				pg.summaryError(error, res, sql);
			else
				Summary.query(req, res, client, done, sql);

			return true;
		});

		return true;
	}

	/**
	 * GET an array of resource Summary objects selected by a specified cid
	 *
	 * @param {string} apikey Unique Identifier for software developer accessing the Maponics Feedback API
	 * @param {number} cid Unique Identifier for individual contact in Summary
	 * @returns {Array} Array of Summary objects
	 * @memberOf Summary
	 * @example
	 * 		{HOST}/resource/getSummaryByContactId?cid=1&apikey=051404be-5e60-4407-b1cf-fb92098ff98e
	 *
	 */
	function getSummaryByContactId( req, res ) {
		var cid = parseInt(req.query.cid);

		if (cid !== cid)
			pg.summaryError('Must provide valid \'cid\' number', res, '');

		else
			pg.connect(req.connection, function (error, client, done) {
				var sql =
					'SELECT ' +
						'r.rid, ' +
						'r.cid, ' +
						'c.organization, ' +
						'r.type, ' +
						'r.zipped, ' +
						'DATE_PART(\'epoch\', r.created) AS created, ' +
						'DATE_PART(\'epoch\', r.modified) AS modified, ' +
						'r.status, ' +
						'r.feedbacksummary, ' +
						'r.feedbacktype, ' +
						'r.featureid, ' +
						'r.featurename, ' +
						'r.featuretype, ' +
						'r.clientinternaljson, ' +
						'r.json, ' +
						'ST_AsGeoJSON(geom, 6) AS geom, ' +
						'r.attachments, '+
						'r.deleted ' +
					'FROM ' +
						config[req.hostname].contact.schema + '."' + config[req.hostname].contact.table + '" c, ' +
						config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" r ' +
					'WHERE c.organization = ' + req.query.organization + ' ' +
						'AND c.cid = $1 ' +
						'AND c.cid = r.cid ' +
					'ORDER BY r.modified;';

				if (error)
					pg.summaryError(error, res, sql);
				else
					Summary.query(req, res, client, done, sql, [cid]);

				return true;
			});

		return true;
	}

	/**
	 * GET an array of resource Summary objects that have been selected by the specified unique Maponics feature ID
	 *
	 * @param {string} apikey Unique Identifier for software developers accessing the Maponics Feedback API
	 * @param {string} featureId Unique Maponics feature ID (eg. nid, mx_id)
	 * @returns {Array} Array of Summary objects
	 * @memberOf Summary
	 * @example
	 *        {HOST}/resource/getSummaryByFeatureId?featureId=VT-TUNBRIDG-17053-VT-PB78987&apikey=051404be-5e60-4407-b1cf-fb92098ff98e
	 *
	 */
	function getSummaryByFeatureId(req, res) {
		pg.connect(req.connection, function (error, client, done) {
			var featureId = req.query.featureId,
				sql = '';
			
			if (featureId && typeof featureId === 'string')
				featureId = featureId.replace(/"/g, '').replace(/'/g, '&apos;');

			if (req.query.organization == 1)
				sql =
					'SELECT ' +
						'rid, ' +
						'cid, ' +
						'type, ' +
						'zipped, ' +
						'DATE_PART(\'epoch\', created) AS created, ' +
						'DATE_PART(\'epoch\', modified) AS modified, ' +
						'status, ' +
						'feedbacksummary, ' +
						'feedbacktype, ' +
						'featureid, ' +
						'featurename, ' +
						'featuretype, ' +
						'clientinternaljson, ' +
						'json, ' +
						'ST_AsGeoJSON(geom, 6) AS geom, ' +
						'attachments, '+
						'deleted ' +
					'FROM ' + config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" ' +
					'WHERE featureid = $1 ' +
					'ORDER BY rid;';
			else
				sql =
					'SELECT ' +
						'r.rid, ' +
						'r.cid, ' +
						'c.organization, ' +
						'r.type, ' +
						'r.zipped, ' +
						'DATE_PART(\'epoch\', r.created) AS created, ' +
						'DATE_PART(\'epoch\', r.modified) AS modified, ' +
						'r.status, ' +
						'r.feedbacksummary, ' +
						'r.feedbacktype, ' +
						'r.featureid, ' +
						'r.featurename, ' +
						'r.featuretype, ' +
						'r.clientinternaljson, ' +
						'r.json, ' +
						'ST_AsGeoJSON(geom, 6) AS geom, ' +
						'r.attachments, '+
						'r.deleted ' +
					'FROM ' +
						config[req.hostname].contact.schema + '."' + config[req.hostname].contact.table + '" c, ' +
						config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" r ' +
					'WHERE c.organization = ' + req.query.organization + ' ' +
						'AND r.featureid = $1 ' +
						'AND c.cid = r.cid ' +
					'ORDER BY r.rid;';

			if (error)
				pg.summaryError(error, res, sql);
			else
				Summary.query(req, res, client, done, sql, [featureId]);

			return true;
		});

		return true;
	}

	/**
	 * GET an array of resource Summary object(s) selected by specified rid(s)
	 *
	 * @param {string} apikey Unique Identifier for software developer accessing the Maponics Feedback API
	 * @param {number} rid Unique Identifier for individual record in Summary
	 * @param {number} rid* Optional - additional comma-delimited rid's can also be specified
	 * @returns {Array} Array with single Summary object or array of Summary objects
	 * @memberOf Summary
	 * @example
	 *        {HOST}/resource/getSummaryByResourceId?rid=221&apikey=051404be-5e60-4407-b1cf-fb92098ff98e
	 * @example
	 *        {HOST}/resource/getSummaryByResourceId?rid=221,222,223&apikey=051404be-5e60-4407-b1cf-fb92098ff98e
	 *
	 */
	function getSummaryByResourceId( req, res ) {
		if (!req.query.rid)
			pg.summaryError('Must provide \'rid\' parameter', res, '');

		else {
			pg.connect(req.connection, function (error, client, done) {
				var param = '',
					sql = '',
					ridArray = req.query.rid.split(',');

				ridArray.forEach(function (rid, index) {
					if (parseInt(rid) === parseInt(rid))
						ridArray[index] = parseInt(rid);
					else
						return pg.summaryError('Must provide valid \'rid\' number', res, '');
				});

				for (var i = 1; i <= ridArray.length; i++) {
					if (i < ridArray.length)
						param += '$' + i + ', ';
					else
						param += '$' + i;
				}

				if (req.query.organization == 1)
					sql =
						'SELECT ' +
							'rid, ' +
							'cid, ' +
							'type, ' +
							'zipped, ' +
							'DATE_PART(\'epoch\', created) AS created, ' +
							'DATE_PART(\'epoch\', modified) AS modified, ' +
							'status, ' +
							'feedbacksummary, ' +
							'feedbacktype, ' +
							'featureid, ' +
							'featurename, ' +
							'featuretype, ' +
							'clientinternaljson, ' +
							'json, ' +
							'ST_AsGeoJSON(geom, 6) AS geom, ' +
							'attachments, '+
							'deleted ' +
						'FROM ' + config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" ' +
						'WHERE rid IN (' + param + ') ' +
						'ORDER BY rid;';
				else
					sql =
						'SELECT ' +
							'r.rid, ' +
							'r.cid, ' +
							'c.organization, ' +
							'r.type, ' +
							'r.zipped, ' +
							'DATE_PART(\'epoch\', r.created) AS created, ' +
							'DATE_PART(\'epoch\', r.modified) AS modified, ' +
							'r.status, ' +
							'r.feedbacksummary, ' +
							'r.feedbacktype, ' +
							'r.featureid, ' +
							'r.featurename, ' +
							'r.featuretype, ' +
							'r.clientinternaljson, ' +
							'r.json, ' +
							'ST_AsGeoJSON(geom, 6) AS geom, ' +
							'r.attachments, ' +
							'r.deleted ' +
						'FROM ' +
							config[req.hostname].contact.schema + '."' + config[req.hostname].contact.table + '" c, ' +
							config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" r ' +
						'WHERE c.organization = ' + req.query.organization + ' ' +
							'AND r.rid IN (' + param + ') ' +
							'AND c.cid = r.cid ' +
						'ORDER BY r.rid;';

				if (error)
					pg.summaryError(error, res, sql);
				else
					Summary.query(req, res, client, done, sql, ridArray);

				return true;
			});
		}

		return true;
	}

	/**
	 * GET an array of resource Summary objects selected by an enumerated status value
	 *
	 * @param {string} apikey Unique Identifier for software developer accessing the Maponics Feedback API
	 * @param {string} status Accepted, Awaiting Review, Completed, Rejected (case sensitive)
	 * @returns {Array} Array of Summary objects
	 * @memberOf Summary
	 * @example
	 *        {HOST}/resource/getSummaryByStatus?status=Awaiting Review&apikey=051404be-5e60-4407-b1cf-fb92098ff98e
	 *
	 */
	function getSummaryByStatus( req, res ) {
		var status = req.query.status ? req.query.status.replace(/["|']/g,'') : '';

		if (status != 'Accepted' && status != 'Awaiting Review' && status != 'Completed' && status != 'Rejected')
			pg.summaryError('Must provide valid \'status\' enumerated value as per getDataDictionary()', res, '');

		else
			pg.connect(req.connection, function (error, client, done) {
				var sql = '';
				
				if (req.query.organization == 1)
					sql =
						'SELECT ' +
							'rid, ' +
							'cid, ' +
							'type, ' +
							'zipped, ' +
							'DATE_PART(\'epoch\', created) AS created, ' +
							'DATE_PART(\'epoch\', modified) AS modified, ' +
							'status, ' +
							'feedbacksummary, ' +
							'feedbacktype, ' +
							'featurename, ' +
							'featureid, ' +
							'featuretype, ' +
							'clientinternaljson, ' +
							'json, ' +
							'ST_AsGeoJSON(geom, 6) AS geom, ' +
							'attachments, '+
							'deleted ' +
						'FROM ' + config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" ' +
						'WHERE status = $1 ' +
						'ORDER BY cid, rid;';
				else
					sql =
						'SELECT ' +
							'r.rid, ' +
							'r.cid, ' +
							'c.organization, ' +
							'r.type, ' +
							'r.zipped, ' +
							'DATE_PART(\'epoch\', r.created) AS created, ' +
							'DATE_PART(\'epoch\', r.modified) AS modified, ' +
							'r.status, ' +
							'r.feedbacksummary, ' +
							'r.feedbacktype, ' +
							'r.featurename, ' +
							'r.featureid, ' +
							'r.featuretype, ' +
							'r.clientinternaljson, ' +
							'r.json, ' +
							'ST_AsGeoJSON(geom, 6) AS geom, ' +
							'r.attachments, '+
							'r.deleted ' +
						'FROM ' +
							config[req.hostname].contact.schema + '."' + config[req.hostname].contact.table + '" c, ' +
							config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" r ' +
						'WHERE c.organization = ' + req.query.organization + ' ' +
							'AND r.status = $1 ' +
							'AND c.cid = r.cid ' +
						'ORDER BY r.cid, r.rid;';

				if (error)
					pg.summaryError(error, res, sql);
				else
					Summary.query(req, res, client, done, sql, [status]);

				return true;
			});

		return true;
	}

	/**
	 * GET an array of resource Summary object IDs (rid) that intersect with the map window / specified bounding box extent
	 *
	 * @param {string} apikey Unique Identifier for software developers accessing the Maponics Feedback API
	 * @param {number} xMin SW Lng decimal degrees
	 * @param {number} yMin SW Lat decimal degrees
	 * @param {number} xMax NE Lng decimal degrees
	 * @param {number} yMax NE Lat decimal degrees
	 *
	 * @returns {Array} Array of Summary object IDs
	 * @memberOf Summary
	 *
	 * @example
	 *      {HOST}/resource/getSummaryIdByExtent?xMin=-76.670837&yMin=39.313715&xMax=-76.579170&yMax=39.341268&apikey=051404be-5e60-4407-b1cf-fb92098ff98e
	 *
	 */
	function getSummaryIdByExtent(req, res) {
		pg.connect(req.connection, function (error, client, done) {
			var extent = [parseFloat(req.query.xMin), parseFloat(req.query.yMin), parseFloat(req.query.xMax), parseFloat(req.query.yMax)],
				wkt = WKT.convert(turf.bboxPolygon(extent).geometry),
				sql = '';
				
			if (req.query.organization == 1)
				sql =
					'SELECT rid ' +
					'FROM ' + config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" ' +
					'WHERE ST_Intersects(ST_GeomFromText($1, 4326), geom) ' +
					'ORDER BY rid;';
			else
				sql =
					'SELECT r.rid ' +
					'FROM ' +
						config[req.hostname].contact.schema + '."' + config[req.hostname].contact.table + '" c, ' +
						config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" r ' +
					'WHERE c.organization = ' + req.query.organization + ' ' +
						'AND ST_Intersects(ST_GeomFromText($1, 4326), geom) ' +
						'AND c.cid = r.cid ' +
					'ORDER BY r.rid;';
					
			if (error)
				pg.summaryError(error, res, sql);
			else
				Summary.query(req, res, client, done, sql, [wkt]);

			return true;
		});

		return true;
	}

	/**
	 * GET an array of resource Summary objects that intersect with the map window / specified bounding box extent
	 *
	 * @param {string} apikey Unique Identifier for software developers accessing the Maponics Feedback API
	 * @param {number} xMin SW Lng decimal degrees
	 * @param {number} yMin SW Lat decimal degrees
	 * @param {number} xMax NE Lng decimal degrees
	 * @param {number} yMax NE Lat decimal degrees
	 * @returns {Array} Array of Summary objects
	 * @memberOf Summary
	 * @example
	 *      {HOST}/resource/getSummaryByExtent?xMin=-76.670837&yMin=39.313715&xMax=-76.579170&yMax=39.341268&apikey=051404be-5e60-4407-b1cf-fb92098ff98e
	 *
	 */
	function getSummaryByExtent(req, res) {
		pg.connect(req.connection, function (error, client, done) {
			var extent = [parseFloat(req.query.xMin), parseFloat(req.query.yMin), parseFloat(req.query.xMax), parseFloat(req.query.yMax)],
				wkt = WKT.convert(turf.bboxPolygon(extent).geometry),
				sql = '';
				
			if (req.query.organization == 1)
				sql =
					'SELECT ' +
						'rid, ' +
						'cid, ' +
						'type, ' +
						'zipped, ' +
						'DATE_PART(\'epoch\', created) AS created, ' +
						'DATE_PART(\'epoch\', modified) AS modified, ' +
						'status, ' +
						'feedbacksummary, ' +
						'feedbacktype, ' +
						'featureid, ' +
						'featurename, ' +
						'featuretype, ' +
						'clientinternaljson, ' +
						'json, ' +
						'ST_AsGeoJSON(geom, 6) AS geom, ' +
						'attachments, '+
						'deleted ' +
					'FROM ' + config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" ' +
					'WHERE ST_Intersects(ST_GeomFromText($1, 4326), geom) ' +
					'ORDER BY rid;';
			else
				sql =
					'SELECT ' +
						'r.rid, ' +
						'r.cid, ' +
						'c.organization, ' +
						'r.type, ' +
						'r.zipped, ' +
						'DATE_PART(\'epoch\', r.created) AS created, ' +
						'DATE_PART(\'epoch\', r.modified) AS modified, ' +
						'r.status, ' +
						'r.feedbacksummary, ' +
						'r.feedbacktype, ' +
						'r.featureid, ' +
						'r.featurename, ' +
						'r.featuretype, ' +
						'r.clientinternaljson, ' +
						'r.json, ' +
						'ST_AsGeoJSON(geom, 6) AS geom, ' +
						'r.attachments, '+
						'r.deleted ' +
					'FROM ' +
						config[req.hostname].contact.schema + '."' + config[req.hostname].contact.table + '" c, ' +
						config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" r ' +
					'WHERE c.organization = ' + req.query.organization + ' ' +
						'AND ST_Intersects(ST_GeomFromText($1, 4326), geom) ' +
						'AND c.cid = r.cid ' +
					'ORDER BY r.rid;';

			if (error)
				pg.summaryError(error, res, sql);
			else
				Summary.query(req, res, client, done, sql, [wkt]);

			return true;
		});

		return true;
	}

	/**
	 * GET an array of resource Summary objects that intersect with the specified search polygon geometry
	 *
	 * @param {string} apikey Unique Identifier for software developers accessing the Maponics Feedback API
	 * @param {string} fc geoJSON FeatureCollection containing polygon geometry
	 * @returns {Array} Array of Summary objects
	 * @memberOf Summary
	 * @example
	 *      {HOST}/resource/getSummaryByPolygon?fc={"type":"FeatureCollection","features":[{"type":"Feature","geometry":{"type":"Polygon","coordinates":[[[-76.62508964538574,39.31992323548977],[-76.62019729614258,39.31710116452751],[-76.61586284637451,39.32091923335418],[-76.61835193634033,39.32735967716445],[-76.62693500518799,39.32805680303453],[-76.62508964538574,39.31992323548977]]]},"properties":{}}]}&apikey=051404be-5e60-4407-b1cf-fb92098ff98e
	 *
	 */
	function getSummaryByPolygon(req, res) {
		pg.connect(req.connection, function (error, client, done) {
			var wkt = WKT.convert(JSON.parse(req.query.fc).features[0].geometry),
			sql = '';
			
			if (req.query.organization == 1)
				sql =
					'SELECT ' +
						'rid, ' +
						'cid, ' +
						'type, ' +
						'zipped, ' +
						'DATE_PART(\'epoch\', created) AS created, ' +
						'DATE_PART(\'epoch\', modified) AS modified, ' +
						'status, ' +
						'feedbacksummary, ' +
						'feedbacktype, ' +
						'featureid, ' +
						'featurename, ' +
						'featuretype, ' +
						'clientinternaljson, ' +
						'json, ' +
						'ST_AsGeoJSON(geom, 6) AS geom, ' +
						'attachments, '+
						'deleted ' +
					'FROM ' + config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" ' +
					'WHERE ST_Intersects(ST_GeomFromText($1, 4326), geom) ' +
					'ORDER BY rid;';
			else
				sql =
					'SELECT ' +
						'r.rid, ' +
						'r.cid, ' +
						'c.organization, ' +
						'r.type, ' +
						'r.zipped, ' +
						'DATE_PART(\'epoch\', r.created) AS created, ' +
						'DATE_PART(\'epoch\', r.modified) AS modified, ' +
						'r.status, ' +
						'r.feedbacksummary, ' +
						'r.feedbacktype, ' +
						'r.featureid, ' +
						'r.featurename, ' +
						'r.featuretype, ' +
						'r.clientinternaljson, ' +
						'r.json, ' +
						'ST_AsGeoJSON(geom, 6) AS geom, ' +
						'r.attachments, '+
						'r.deleted ' +
					'FROM ' +
						config[req.hostname].contact.schema + '."' + config[req.hostname].contact.table + '" c, ' +
						config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" r ' +
					'WHERE c.organization = ' + req.query.organization + ' ' +
						'AND ST_Intersects(ST_GeomFromText($1, 4326), geom) ' +
						'AND c.cid = r.cid ' +
					'ORDER BY r.rid;';

			if (error)
				pg.summaryError(error, res, sql);
			else
				Summary.query(req, res, client, done, sql, [wkt]);

			return true;
		});

		return true;
	}

	/**
	 * GET an array of resource Summary objects that intersect with the specified radius of the specified WGS84 lat/lng coordinate
	 *
	 * @param {string} apikey Unique Identifier for software developers accessing the Maponics Feedback API
	 * @param {number} lat Latitude decimal degrees
	 * @param {number} lng Longitude decimal degrees
	 * @param {number} radius Search distance
	 * @param {string} unit Miles
	 * @returns {Array} Array of Summary objects
	 * @memberOf Summary
	 * @example
	 *        {HOST}/resource/getSummaryByRadius?lat=39.328206&lng=-76.61739&radius=2&unit=miles&apikey=051404be-5e60-4407-b1cf-fb92098ff98e
	 *
	 */
	function getSummaryByRadius(req, res) {
		pg.connect(req.connection, function (error, client, done) {
			var point = turf.point([parseFloat(req.query.lng), parseFloat(req.query.lat)]),
				buffer = turf.buffer(point, parseFloat(req.query.radius), req.query.unit),
				wkt = WKT.convert(buffer.features[0].geometry),
				sql = '';
				
			if (req.query.organization == 1)
				sql =
					'SELECT ' +
						'rid, ' +
						'cid, ' +
						'type, ' +
						'zipped, ' +
						'DATE_PART(\'epoch\', created) AS created, ' +
						'DATE_PART(\'epoch\', modified) AS modified, ' +
						'status, ' +
						'feedbacksummary, ' +
						'feedbacktype, ' +
						'featureid, ' +
						'featurename, ' +
						'featuretype, ' +
						'clientinternaljson, ' +
						'json, ' +
						'ST_AsGeoJSON(geom, 6) AS geom, ' +
						'attachments, '+
						'deleted ' +
					'FROM ' + config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" ' +
					'WHERE ST_Intersects(ST_GeomFromText($1, 4326), geom) ' +
					'ORDER BY rid;';
			else
				sql =
					'SELECT ' +
						'r.rid, ' +
						'r.cid, ' +
						'c.organization, ' +
						'r.type, ' +
						'r.zipped, ' +
						'DATE_PART(\'epoch\', r.created) AS created, ' +
						'DATE_PART(\'epoch\', r.modified) AS modified, ' +
						'r.status, ' +
						'r.feedbacksummary, ' +
						'r.feedbacktype, ' +
						'r.featureid, ' +
						'r.featurename, ' +
						'r.featuretype, ' +
						'r.clientinternaljson, ' +
						'r.json, ' +
						'ST_AsGeoJSON(geom, 6) AS geom, ' +
						'r.attachments, '+
						'r.deleted ' +
					'FROM ' +
						config[req.hostname].contact.schema + '."' + config[req.hostname].contact.table + '" c, ' +
						config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" r ' +
					'WHERE c.organization = ' + req.query.organization + ' ' +
						'AND ST_Intersects(ST_GeomFromText($1, 4326), geom) ' +
						'AND c.cid = r.cid ' +
					'ORDER BY r.rid;';

			if (error)
				pg.summaryError(error, res, sql);
			else
				Summary.query(req, res, client, done, sql, [wkt]);

			return true;
		});

		return true;
	}

	/**
	 * GET an array of resource Summary objects that have been modified within a specified date interval (eg. last 7 days)
	 * and email a report thereof to a list of Maponics managers contained in the 'Managers' table
	 *
	 * @param {string} apikey Unique Identifier for software developers accessing the Maponics Feedback API
	 * @param {number} days Date interval in days (0 = today)
	 * @returns {Array} Array of Summary objects
	 * @memberOf Summary
	 * @example
	 *        {HOST}/resource/getSummaryByDateInterval?days=7&apikey=051404be-5e60-4407-b1cf-fb92098ff98e
	 *
	 */
	function getSummaryByDateInterval(req, res) {
		var days = parseInt(req.query.days);

		if (days !== days)
			pg.summaryError('Must provide valid \'days\' number', res, '');

		else if (days < 0)
			pg.summaryError('Must provide \'days\' number >= 0', res, '');

		else
			pg.connect(req.connection, function (error, client, done) {
				var sql = '';
				
				if (req.query.organization == 1)
					sql =
						'SELECT ' +
							'rid, ' +
							'cid, ' +
							'type, ' +
							'zipped, ' +
							'DATE_PART(\'epoch\', created) AS created, ' +
							'DATE_PART(\'epoch\', modified) AS modified, ' +
							'status, ' +
							'feedbacksummary, ' +
							'feedbacktype, ' +
							'featureid, ' +
							'featurename, ' +
							'featuretype, ' +
							'clientinternaljson, ' +
							'json, ' +
							'ST_AsGeoJSON(geom, 6) AS geom, ' +
							'attachments, '+
							'deleted ' +
						'FROM ' + config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" ' +
						'WHERE modified > now()::date - ' + days + ' AND deleted = ' + false + ' ' +
						'ORDER BY modified DESC;';
				else
					sql =
						'SELECT ' +
							'r.rid, ' +
							'r.cid, ' +
							'c.organization, ' +
							'r.type, ' +
							'r.zipped, ' +
							'DATE_PART(\'epoch\', r.created) AS created, ' +
							'DATE_PART(\'epoch\', r.modified) AS modified, ' +
							'r.status, ' +
							'r.feedbacksummary, ' +
							'r.feedbacktype, ' +
							'r.featureid, ' +
							'r.featurename, ' +
							'r.featuretype, ' +
							'r.clientinternaljson, ' +
							'r.json, ' +
							'ST_AsGeoJSON(geom, 6) AS geom, ' +
							'r.attachments, '+
							'r.deleted ' +
						'FROM ' +
							config[req.hostname].contact.schema + '."' + config[req.hostname].contact.table + '" c, ' +
							config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" r ' +
						'WHERE c.organization = ' + req.query.organization + ' ' +
							'AND r.modified > now()::date - ' + days + ' AND r.deleted = ' + false + ' ' +
							'AND c.cid = r.cid ' +
						'ORDER BY r.modified DESC;';

				if (error)
					pg.summaryError(error, res, sql);
					
				else {
					req.notify = 'manager';
					Summary.query(req, res, client, done, sql);
				}

				return true;
			});

		return true;
	}

	/**
	 * Mark the resource Summary object specified rid, if any, as 'deleted'.
	 *
	 * @param {string} apikey Unique Identifier for software developer accessing the Maponics Feedback API
	 * @param {number} rid Unique Identifier for individual record in Summary
	 * @returns {Array} Array of Summary objects
	 * @memberOf Summary
	 * @example
	 *        {HOST}/resource/deleteSummaryByResourceId?rid=240&apikey=051404be-5e60-4407-b1cf-fb92098ff98e
	 *
	 */
	function deleteSummaryByResourceId( req, res ) {
		var rid = parseInt(req.query.rid);

		if (rid !== rid)
			pg.summaryError('Must provide valid \'rid\' number', res, '');

		else
			pg.connect(req.connection, function (error, client, done) {
				var sql =
					'UPDATE ' + config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" ' +
					'SET ' +
						'deleted = ' + true + ', ' +
						'modified = CURRENT_TIMESTAMP ' +
					'WHERE rid = $1 ' +
					'RETURNING ' +
						'rid, ' +
						'cid, ' +
						'type, ' +
						'zipped, ' +
						'DATE_PART(\'epoch\', created) AS created, ' +
						'DATE_PART(\'epoch\', modified) AS modified, ' +
						'status, ' +
						'feedbacksummary, ' +
						'feedbacktype, ' +
						'featureid, ' +
						'featurename, ' +
						'featuretype, ' +
						'clientinternaljson, ' +
						'json, ' +
						'ST_AsGeoJSON(geom, 6) AS geom, ' +
						'attachments, '+
						'deleted;';

				if (error)
					pg.summaryError(error, res, sql);
				else
					Summary.query(req, res, client, done, sql, [rid]);

				return true;
			});

		return true;
	}

	/**
	 * UPDATE the enumerated status value for a resource Summary object selected by a specified rid and
	 * send a status change email to the contact who initiated the summary resource feedback originally
	 * if the change in feedback status is different than the existing feedback status
	 *
	 * @param {string} apikey Unique Identifier for software developer accessing the Maponics Feedback API
	 * @param {number} rid Unique Identifier for individual record in Summary
	 * @param {string} status Accepted, Awaiting Review, Completed, Rejected (case sensitive)
	 * @param {string} note Production department note regarding the change in status (optional)
	 * @returns {Array} Array with single Summary object
	 * @memberOf Summary
	 * @example
	 *        {HOST}/resource/updateSummaryStatusByResourceId?rid=198&status=Accepted&apikey=051404be-5e60-4407-b1cf-fb92098ff98e
	 *
	 */
	function updateSummaryStatusByResourceId( req, res ) {
		var rid = parseInt(req.query.rid);

		if (rid !== rid)
			pg.summaryError('Must provide valid \'rid\' number', res, '');

		else
			pg.connect(req.connection, function (error, client, done) {
				var sql = '';
				
				if (req.query.organization == 1)
					sql =
						'SELECT status ' +
						'FROM ' + config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" ' +
						'WHERE rid = $1;';
				else
					sql =
						'SELECT status ' +
						'FROM ' +
							config[req.hostname].contact.schema + '."' + config[req.hostname].contact.table + '" c, ' +
							config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" r ' +
						'WHERE c.organization = ' + req.query.organization + ' ' +
							'AND r.rid = $1 ' +
							'AND c.cid = r.cid;';

				if (error)
					pg.summaryError(error, res, sql);

				else
					client.query(sql, [rid], function (error, result) {
						if (error)
							pg.summaryError(error, res, sql);

						else if (result.rowCount > 0) {
							var newStatus = req.query.status ? req.query.status.replace(/["|']/g,'') : '',
								oldStatus = result.rows[0].status;

							if (newStatus != 'Accepted' && newStatus != 'Awaiting Review' && newStatus != 'Completed' && newStatus != 'Rejected')
								pg.summaryError('Must provide valid \'status\' enumerated value', res, '');

							else
								pg.connect(req.connection, function (error, client, done) {
									var sql =
										'UPDATE ' + config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" ' +
										'SET ' +
											'status = \'' + newStatus + '\', ' +
											'modified = CURRENT_TIMESTAMP ' +
										'WHERE rid = $1 ' +
										'RETURNING ' +
											'rid, ' +
											'cid, ' +
											'type, ' +
											'zipped, ' +
											'DATE_PART(\'epoch\', created) AS created, ' +
											'DATE_PART(\'epoch\', modified) AS modified, ' +
											'status, ' +
											'feedbacksummary, ' +
											'feedbacktype, ' +
											'featureid, ' +
											'featurename, ' +
											'featuretype, ' +
											'clientinternaljson, ' +
											'json, ' +
											'ST_AsGeoJSON(geom, 6) AS geom, ' +
											'attachments, '+
											'deleted;';

									if (error)
										pg.summaryError(error, res, sql);

									else {
										if (newStatus != oldStatus) {
											req.notify = 'status';
											req.oldStatus = oldStatus;
										}

										Summary.query(req, res, client, done, sql, [rid]);
									}

									return true;
								});

						} else if (result.rowCount == 0) {
							Debugger.on = true;
							Debugger.log('No rows received for: \n' + sql);
							res.status(200).send([]);
						}

						return done();
					});

				return true;
			});

		return true;
	}

	/* this => instance properties & methods */
	Summary.prototype.init = function( summaryData ) {
		Debugger.on = true;
		//Debugger.log( summaryData );
		
		if(! 'cid' in summaryData ) {
			if(! 'rid' in summaryData ) {
				var error = "Invalid data provided for Summary";
				Debugger.log( req.body, error +":\n $1" );
				res.status(200).send([{"Error": error}]);
			
				return null;
			}
		}

		this.rid = (summaryData.rid) ? parseInt(summaryData.rid) : undefined;
		this.cid = (typeof summaryData.cid !== undefined) ? parseInt(summaryData.cid) : undefined;
		this.modified = summaryData.modified;
		this.created = summaryData.created;
		this.deleted = summaryData.deleted;
		this.type = summaryData.type;
		this.zipped = summaryData.zipped;
		this.status = summaryData.status;
		this.clientinternaljson = summaryData.clientinternaljson;
		this.feedbacksummary = summaryData.feedbacksummary;
		this.feedbacktype = summaryData.feedbacktype;
		this.featureid = summaryData.featureid;
		this.featurename = summaryData.featurename;
		this.featuretype = summaryData.featuretype;
		this.geom = summaryData.geom;
		this.json = (typeof summaryData.json === 'object' && summaryData.json !== null) ? 
						JSON.stringify(summaryData.json) :
						summaryData.json;
		this.attachments = (typeof summaryData.attachments === 'object' && summaryData.attachments !== null) ? 
						JSON.stringify(summaryData.attachments) :
						summaryData.attachments;

		/* Seeing empty geometry field returned from postgres,
		 * so trying to reconcile with the following code block
		 */
		if (!this.geom || this.geom === null) {
			if (summaryData.json && typeof summaryData.json.features === 'object' &&
				summaryData.json.features !== null && 'geometry' in summaryData.json.features[0]) {

				this.geom = JSON.stringify(summaryData.json.features[0].geometry);
			}
		}

		if (typeof this.clientinternaljson === 'string')
			this.clientinternaljson.replace(/(^")/g, '').replace(/("$)/g, '');

		if (typeof this.json === 'string')
			this.json.replace(/(^")/g, '').replace(/("$)/g, '');

		if (typeof this.attachments=== 'string')
			this.attachments.replace(/(^")/g, '').replace(/("$)/g, '');

		if (typeof this.created === 'number')
			this.created = parseInt(this.created.toString().match(/(\d+)\.*\d*/)[1]);

		if (typeof this.modified === 'number')
			this.modified = parseInt(this.modified.toString().match(/(\d+)\.*\d*/)[1]);

		/* Register files to be hidden on req object */
		for( var i=0; i<10; i++ ) if( summaryData['hide['+ i +']']) {
			var aid = summaryData['hide['+ i +']'].match(/[A-Za-z0-9|\-|\_|\s|\.]+/)[0];
			Summary.hide = Summary.hide || [];
			
			if( summaryData['hide-'+ aid] && summaryData['hide-'+ aid] === "on" ) {
				Debugger.log( summaryData['hide-'+ aid], "hide-"+ aid +": $1");
				Summary.hide.push(aid);
			}			
		}
		
		return this;
	};
	
	/**
	 * POST (Save) the Summary object. Use the posted object to create a new 
	 * resource Summary. This object can be supplied either as a raw json body 
	 * (application/json), url-encoded form fields (application/x-www-form-urlencoded), 
	 * or multipart form fields (multipart/form-data). An external file may also be 
	 * attached to the Summary record. This file must be included as a field named 
	 * <em>data</em> in a multipart form (multipart/form-data). The json-array field
     * (<em>attachments</em>) which tracks the meta-data for this optional file attachment
     * is essentially read-only and internally manipulated by the API service.
	 *
	 * @param {string} apikey Unique Identifier for software developer accessing the Maponics Feedback API
	 * @param {object} Summary A Summary object with minimal required properties/fields, 
	 * 						which are: <em>cid</em>, a valid Contact ID reference (number); 
	 * 						<em>type</em>, the Resource Type (string); and <em>zipped</em>, the 
	 * 						Resource Compressed flag (boolean; the absence of this property indicates 
	 * 						a false value).
	 * 						Additional properties for this object that may optionally be supplied,
	 *						including: <em>attachments</em>, properties of Access URIs which 
	 *						provide	direct read-access to external files (json[read-only]); 
	 * 						<em>json</em>, a JSON object or array (json); <em>status</em>, a description 
	 * 						of the current working state of this resource; <em>feedbacksummary</em>, 120
	 *						char max text note; <em>feedbacktype</em>, enumerated feedback type re data
	 *						dictionary; <em>featureid</em>, Maponics unique feature ID (eg. nid, mx_id);
	 *						<em>featuretype</em>, enumerated feature type re data dictionary;
	 *                      <em>featurename</em>, feature name - CASE AND PUNCTUATION SENSITIVE and
	 *                      <em>clientinternaljson</em>, client internal ticketing system ID (optional).
	 * @param {object} data The file to be uploaded to S3 and associated with 
	 *						this Summary record (POST as multipart/form-data) 
	 * 
	 * @returns {Array} Array with single Summary object
	 *
	 * @memberOf Summary
	 * 
	 * @example
	 * 		{HOST}/resource/save/?apikey=051404be-5e60-4407-b1cf-fb92098ff98e
	 * 
	 * 	 	{
	 * 			"cid": 	1,
	 * 			"type": "PNG",
	 * 			"zipped": true,
	 * 			"status": "Save zipped PNG file to Amazon S3",
	 * 			"feedbacksummary": "added new feature",
	 * 			"feedbacktype": "feature add",
	 * 			"featureid": "NH-NEWPORT -9891",
	 * 			"featurename": "NEWPORT",
	 * 			"featuretype": "School District",
	 * 			"clientinternaljson": "12345",
	 * 			"json": {}
	 * 		}
	 *
	 */
	Summary.prototype.save = function save(req, res) {
		Debugger.on = false; // Set to true for debug
		
		var that = this;
		
		Debugger.log( that );

		if (that.cid !== that.cid && typeof that.cid !== 'number')
			pg.summaryError('Must provide valid Contact ID reference \'cid\' number', res, '');

		else if (that.type && typeof that.type !== 'string')
			pg.summaryError('Must provide valid Resource Type \'type\'', res, '');

		else pg.connect(req.connection, function (error, client, done) {
			var index = 1,
				param = [],
				fields = '',
				values = '',
				wkt = '';

			if (that.geom && that.type === 'EmbeddedGeoJSON')
				wkt = WKT.convert(JSON.parse(that.geom));

			if (that.zipped && typeof that.zipped === 'string')
				that.zipped = that.zipped !== 'false' ? true : false;

			Debugger.log( (!!wkt), "wkt evaluates to: $1" );

			for (var p in that) {
				
				/* This parsing routine should not include properties
				 * that have empty strings ("") as values.
				 */
				if (p !== 'geom' && !!that[p] && typeof that[p] !== 'function') {
					Debugger.log( "Property to be inserted in Summary: "+ p );

					fields += p + ', ';
					values += '$' + index + ', ';

					if (typeof that[p] === 'boolean')
						param.push(that[p]);

					else if (typeof that[p] === 'number')
						param.push(parseInt(that[p]));

					else if (typeof that[p] === 'string') {
						if (p == 'json' || p == 'clientinternaljson' || p == 'attachments')
							param.push(that[p].replace(/'/g, '&apos;'));
						else
							param.push(that[p].replace(/"/g, '').replace(/'/g, '&apos;'));
					}

					index++;
				}
			}

			var sql =
				'INSERT INTO ' + config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" (' +
					fields +
					((!!wkt) ? 'geom, ' : '') +
					'created, ' +
					'modified) ' +
				'VALUES (' +
					values +
					((!!wkt) ? 'ST_GeomFromText(\'' + wkt + '\', 4326), ' : '') +
					'CURRENT_TIMESTAMP, ' +
					'CURRENT_TIMESTAMP) ' +
				'RETURNING ' +
					'rid, ' +
					'cid, ' +
					'type, ' +
					'zipped, ' +
					'DATE_PART(\'epoch\', created) AS created, ' +
					'DATE_PART(\'epoch\', modified) AS modified, ' +
					'status, ' +
					'feedbacksummary, ' +
					'feedbacktype, ' +
					'featureid, ' +
					'featurename, ' +
					'featuretype, ' +
					'clientinternaljson, ' +
					'json, ' +
					((!!wkt) ? 'ST_AsGeoJSON(geom, 6) AS geom, ' : '') +
					'attachments, ' +
					'deleted;';

			if (error)
				pg.summaryError(error, res, sql);
			else
				Summary.query(req, res, client, done, sql, param);

			return true;
		});

		return this;
	};

	/**
	 * POST (Update) the Summary object. Use the posted object to update values
	 * of the resource Summary specified by the 'rid' property. This object can 
	 * be supplied either as a raw json body (application/json), url-encoded 
	 * form fields (application/x-www-form-urlencoded), or multipart form fields 
	 * (multipart/form-data). An external file may also be attached to the Summary 
	 * record. This file must be included as a field named <em>data</em> in a multipart 
	 * form (multipart/form-data).The json-array field (<em>attachments</em>) which 
     * tracks the meta-data for this optional file attachment is essentially read-only 
     * and internally manipulated by the API service.
	 *
	 * @param {string} apikey Unique Identifier for software developer accessing the Maponics Feedback API
	 * @param {object} Summary A Summary object with a valid <em>rid</em> property and any of
	 * 						the following updatable properties/fields: <em>cid</em>, a valid 
	 * 						Contact ID reference (number); <em>type</em>, the Resource Type
	 * 						(string); <em>zipped</em>, the Resource Compressed flag (boolean); 
	 * 						<em>attachments</em>, properties of Access URIs which provide direct 
	 * 						read-access to external files (json) ...DOCUMENTATION WILL BE UPDATED...; 
	 * 						<em>json</em>, a JSON object or array (json); <em>status</em>, a 
	 * 						description of the current working state of this resource;
	 *                      <em>feedbacksummary</em>, 120 char max text note; <em>feedbacktype</em>, enumerated
	 *                      feedback type re data dictionary; <em>featureid</em>, Maponics unique feature ID
	 *                      (eg. nid, mx_id); <em>featuretype</em>, enumerated feature type re data dictionary;
	 *                      <em>featurename</em>, feature name - CASE AND PUNCTUATION SENSITIVE and
	 *                      <em>clientinternaljson</em>, client internal ticketing system ID (optional).
	 * @param {object} data The file to be uploaded to S3 and associated with 
	 *						this Summary record (POST as multipart/form-data) 
	 *
	 * @returns {Array} Array with single Summary object
	 *
	 * @memberOf Summary
	 *
	 * @example
	 * 		{HOST}/resource/update/?apikey=051404be-5e60-4407-b1cf-fb92098ff98e
	 * 
	 * 	 	{
	 *			"cid": 	1,
	 *			"rid" : 2,
	 * 			"type": "JPG",
	 * 			"status": "Converted resource to zipped JPG",
	 * 			"feedbacksummary": "updated new feature",
	 * 			"feedbacktype": "feature update",
	 * 			"featureid": "21211",
	 * 			"featurename": "21211",
	 * 			"featuretype": "ZIP Code",
	 * 			"json": { "conversion": "png2jpg" }
	 * 		}
	 *
	 */
	Summary.prototype.update = function update( req, res ) {
		var that = this;

		if (!that.rid && that.rid !== that.rid && typeof that.rid !== 'number') {
			pg.summaryError('Must provide valid Resource Summary ID \'rid\' number', res, '');

		} else {
			pg.connect(req.connection, function (error, client, done) {
				var index = 1,
					param = [],
					set = '',
					wkt = '';

				if (that.geom && that.type === 'EmbeddedGeoJSON')
					wkt = (typeof that.geom === 'string')? 
						WKT.convert(JSON.parse(that.geom)):
						WKT.convert(that.geom);

				if (that.zipped && typeof that.zipped === 'string')
					that.zipped = that.zipped !== 'false' ? true : false;

				//Debugger.log( (!!wkt), "wkt evaluates to: $1" );

				for (var p in that) {
					/* This parsing routine should not include properties
					 * that have empty strings ("") as values.
					 */
					if( p !== 'cid' && 
						p !== 'created' && 
						p !== 'modified' && 
						p !== 'geom' && 
						!!that[p] && typeof that[p] !== 'function'
					) {
						//Debugger.log( "Property to be updated in Summary: "+ p );

						set += p + '=$' + index + ', ';

						if (typeof that[p] === 'boolean')
							param.push(that[p]);

						else if (typeof that[p] === 'number')
							param.push(parseInt(that[p]));

						else if (typeof that[p] === 'object') {
							that[p] = JSON.stringify(that[p]);
							param.push(that[p].replace(/'/g, '&apos;'));
							
						} else if (typeof that[p] === 'string') {
							if (p == 'json' || p == 'clientinternaljson' || p == 'attachments')
								param.push(that[p].replace(/'/g, '&apos;'));
							else
								param.push(that[p].replace(/"/g, '').replace(/'/g, '&apos;'));
							
						} else /* Need an else (default) block */ {
							param.push(that[p].toString());
						}
						
						//Debugger.log( param[index - 1] );

						index++;
					}
				}

				var sql =
					'UPDATE ' + config[req.hostname].resource.schema + '."' + config[req.hostname].resource.table + '" ' +
					'SET ' +
						set +
						((!!wkt) ? 'geom = ST_GeomFromText(\'' + wkt + '\', 4326), ' : '') +
						'modified = CURRENT_TIMESTAMP ' +
					'WHERE rid = $1 ' +
					'RETURNING ' +
						'rid, ' +
						'cid, ' +
						'type, ' +
						'zipped, ' +
						'DATE_PART(\'epoch\', created) AS created, ' +
						'DATE_PART(\'epoch\', modified) AS modified, ' +
						'status, ' +
						'feedbacksummary, ' +
						'feedbacktype, ' +
						'featureid, ' +
						'featurename, ' +
						'featuretype, ' +
						'clientinternaljson, ' +
						'json, ' +
						((!!wkt) ? 'ST_AsGeoJSON(geom, 6) AS geom, ' : '') +
						'attachments, ' +
						'deleted;';

				if (error) {
					pg.summaryError(error, res, sql);

				} else {
					Summary.query(req, res, client, done, sql, param);	
					
					var debug = sql;
					
					for( var p=1, z=param.length; p < z; p++ ) {
						var parameter = new RegExp('\\\$' + (p + 1));
						debug = debug.replace(parameter, "'"+ param[p].toString() +"'");
					}
					
					Debugger.log( "Update SQL:\n"+ debug );
		
					Debugger.log( Summary.hide, "Summary.hide is $1" );
			
					if( Summary.hide && Summary.hide[0] !== undefined ) {
						/* Using Q promises
						 * Check out https://youtu.be/hf1T_AONQJU?t=14m
						 */
						Summary.hidePromise = Q.Promise(function( resolve, reject, notify ) {
							pg.connect(req.connection, function (error, client, done) {
								var sql = '',
									aids = '';

								if (error) {
									pg.summaryError(error, res, sql);
									reject(error);

								} else {
									Summary.hide.forEach(function( aid ) {
										if( aids ) aids += ' OR aid=\''+ aid +'\'';
										else aids = ' aid=\''+ aid +'\'';
									});

									sql = '\
SELECT rid, idx, attachment FROM ( \
  SELECT rid, CAST(row_number() over() AS integer) AS idx, attachment, attachment->>\'id\' AS aid FROM ( \
    SELECT \
		rid, \
		json_array_elements(array_to_json(attachments)) AS attachment \
		FROM resource."Summary" \
		WHERE rid='+ that.rid +') all_attachments \
) not_hidden_attachments WHERE'+ aids +';';

									Debugger.log( sql );

									client.query(sql, function (error, result) {
										if (error) {
											pg.summaryError(error, res, sql);
											reject(error);

										} else {
											Debugger.log( result.rows, "Returned from hide attachment query:\n$1" );
											resolve(result.rows);
										}

										return true;
									});

									return true;
								}
							});

						});

						Debugger.log(Summary.hidePromise);
					}
				}
				
				return true;
			});
		}

		return this;
	};

	Summary.prototype.attachFile = 
	function( req, res ) {
		Debugger.on = true;
		
		if (!this.rid && this.rid !== this.rid && typeof this.rid !== 'number') {
			pg.summaryError('Must provide valid Resource Summary ID \'rid\' number', res, '');
			return this;
		} else if(! req.files ) {
			pg.summaryError('Must provide valid File as \'data\' in POST body', res, '');
			return this;
		}
		
		var testPutObject,
			files = req.files,
			that = this,
			time = new Date(),
			bucket,
			bucket_name = "feedbackplatformattachments",
			bucket_key = "fromwebapp/" + that.rid,
			access_prefix = "https://s3.amazonaws.com/";
		
		req.files = '';
		
		for( var f in files ) if( files[f]['path'] && (files[f]['size'] > 0) ) {
			var file = files[f], 
				resource = {};
			
			Debugger.log( file );
			
			resource.name = file.name.replace(/[,|\s]/g, "_").match(/[A-Za-z0-9|\-|\_|\s|\.]+/)[0];
			resource.path = file.path.replace(/\\\\/, "\\");
			resource.tag = [];

			Debugger.log( resource );
		
			/* Get Bucket list and assign first bucket var */
			s3.listBuckets(function(err, data) {
				if (err) Debugger.log(err, err.stack);	// an error occurred
				else {									// successful response
					Debugger.log( data );
					if( data.Buckets !== undefined && data.Buckets !== null ) {
						bucket = data.Buckets.shift();
						Debugger.log( bucket );

						/* Test writability of bucket by pushing resource file */
						if(bucket && bucket.Name === bucket_name) testPutObject(resource);
						else Debugger.log( bucket, "Wrong bucket: $1" );
					}
				}
			});

			testPutObject = function( resource ) {
				var putParams = {
					Bucket: bucket.Name, /* required */
					Key: bucket_key +"/"+ resource.name, /* required */
				//	ACL: 'private | public-read | public-read-write | authenticated-read |  bucket-owner-read | bucket-owner-full-control',
					ACL: 'authenticated-read',
					Body: fs.createReadStream(resource.path),
				//	CacheControl: 'STRING_VALUE',
				//	ContentDisposition: 'STRING_VALUE',
				//	ContentEncoding: 'STRING_VALUE',
				//	ContentLanguage: 'STRING_VALUE',
				//	ContentLength: 0,
				//	ContentMD5: 'STRING_VALUE',
				//	ContentType: 'STRING_VALUE',
					ContentType: (resource.name.match(/(?:\.gif)/) !== null)? 
								"image/gif":
								(resource.name.match(/(?:\.jpg|\.jpeg)/) !== null)? 
								"image/jpeg":
								(resource.name.match(/(?:\.png)/) !== null)? 
								"image/png":
								(resource.name.match(/(?:\.svg)/) !== null)? 
								"image/svg+xml":
								"application/octet-stream"
				//	Expires: new Date,
				//	GrantFullControl: 'STRING_VALUE',
				//	GrantRead: 'STRING_VALUE',
				//	GrantReadACP: 'STRING_VALUE',
				//	GrantWriteACP: 'STRING_VALUE',
				//	Metadata: {
				//		someKey: 'STRING_VALUE',
				//		/* anotherKey: ... */
				//	},
				//	RequestPayer: 'requester',
				//	SSECustomerAlgorithm: 'STRING_VALUE',
				//	SSECustomerKey: 'STRING_VALUE',
				//	SSECustomerKeyMD5: 'STRING_VALUE',
				//	SSEKMSKeyId: 'STRING_VALUE',
				//	ServerSideEncryption: 'AES256',
				//	StorageClass: 'STANDARD | REDUCED_REDUNDANCY',
				//	WebsiteRedirectLocation: 'STRING_VALUE'
				};

				s3.putObject(putParams, function(err, data) {
					if (err) Debugger.log(err, err.stack);	// an error occurred
					else {									// successful response
						Debugger.log( data );
						var attachment = {
							id: resource.name,
							cid: that.cid,
							type: "S3",
							url: access_prefix + bucket_name +"/"+ bucket_key +"/"+ resource.name,
							auth: "",
							modified: Math.floor(time.valueOf() / 1000),
							hidden: false
						};

						if( data.ETag !== undefined ) {
							resource.tag.push(data.ETag.replace(/["|']/g, ''));
							Debugger.log( resource.tag );

							attachment.id = attachment.id.replace(/(\.\w+)?$/, "."+ resource.tag +"$1") || attachment.id;
						}

						Debugger.log( attachment );

						pg.connect(req.connection, function (error, client, done) {
							var sql = 'UPDATE resource."Summary" '+
										'SET attachments = '+
											'array_append(attachments, \'{"id":"'+ 
																			attachment.id 
																		+'","type":"'+ 
																			attachment.type 
																		+'","url":"'+
																			attachment.url	
																		+'","auth":"'+
																			attachment.auth	
																		+'","contact":"'+
																			attachment.cid	
																		+'","modified":"'+
																			attachment.modified
																		+'","hidden":"'+
																			attachment.hidden
																		+'"}\') '+
										'WHERE rid='+ that.rid +' '+
										'RETURNING ' +
											'rid, ' +
											'cid, ' +
											'type, ' +
											'zipped, ' +
											'DATE_PART(\'epoch\', created) AS created, ' +
											'DATE_PART(\'epoch\', modified) AS modified, ' +
											'status, ' +
											'feedbacksummary, ' +
											'feedbacktype, ' +
											'featureid, ' +
											'featurename, ' +
											'featuretype, ' +
											'clientinternaljson, ' +
											'json, ' +
											'ST_AsGeoJSON(geom, 6) AS geom, ' +
											'attachments, '+
											'deleted;';

							if (error) {
								pg.summaryError(error, res, sql);

							} else {
								Summary.query(req, res, client, done, sql);
								
								fs.unlink(resource.path, function(err) {
									if( err ) Debugger.log( err, "File deletion error: $1");
									else Debugger.log( "Temp file was deleted.");
								});
							}

							return true;
						});
					}
				});
			};
		}
		
		return this;	
	};
	
	Debugger.on = false;

	if (typeof req !== 'object' && typeof summaryData === 'object')
		return this.init(summaryData);
	else if (req.path.match(/\/(?:getDataDictionary)/) !== null)
		return getDataDictionary(req, res);
	else if (req.path.match(/\/(?:getAllSummaries)/) !== null)
		return getAllSummaries(req, res);
	else if (req.path.match(/\/(?:getSummaryByOrganization)/) !== null)
		return getSummaryByOrganization(req, res);
	else if (req.path.match(/\/(?:getSummaryByContactId)/) !== null)
		return getSummaryByContactId(req, res);
	else if (req.path.match(/\/(?:getSummaryByFeatureId)/) !== null)
		return getSummaryByFeatureId(req, res);
	else if (req.path.match(/\/(?:getSummaryByResourceId)/) !== null)
		return getSummaryByResourceId(req, res);
	else if (req.path.match(/\/(?:getSummaryByStatus)/) !== null)
		return getSummaryByStatus(req, res);
	else if (req.path.match(/\/(?:getSummaryIdByExtent)/) !== null)
		return getSummaryIdByExtent(req, res);
	else if (req.path.match(/\/(?:getSummaryByExtent)/) !== null)
		return getSummaryByExtent(req, res);
	else if (req.path.match(/\/(?:getSummaryByPolygon)/) !== null)
		return getSummaryByPolygon(req, res);
	else if (req.path.match(/\/(?:getSummaryByRadius)/) !== null)
		return getSummaryByRadius(req, res);
	else if (req.path.match(/\/(?:getSummaryByDateInterval)/) !== null)
		return getSummaryByDateInterval(req, res);
	else if (req.path.match(/\/(?:deleteSummaryByResourceId)/) !== null)
		return deleteSummaryByResourceId(req, res);
	else if (req.path.match(/\/(?:updateSummaryStatusByResourceId)/) !== null)
		return updateSummaryStatusByResourceId(req, res);
	else if (req.path.match(/\/(?:save)/) !== null)
		return (new Summary(summaryData)).save(req, res);
	else if (req.path.match(/\/(?:update)/) !== null)
		return (new Summary(summaryData)).update(req, res);
	else if (req.path.match(/\/editor(\.html)?$/) !== null && req.query.rid)
		return getSummaryByResourceId(req, res);
	else if (req.path.match(/\/summaries(\.html)?$/) !== null && req.query.rid)
		return getSummaryByResourceId(req, res);
	else if (req.path.match(/\/summaries(\.html)?$/) !== null && req.query.cid > 0 && req.query.role === 'User')
		return getSummaryByContactId(req, res);
	else if (req.path.match(/\/summaries(\.html)?$/) !== null && req.query.cid > 0 && req.query.role === 'Admin')
		return getSummaryByOrganization(req, res);
	else if (req.path.match(/\/summaries(\.html)?$/) !== null && req.query.cid === 0)
		return getAllSummaries(req, res);
	else
		return getAllSummaries(req, res);
}

module.exports = Summary;
