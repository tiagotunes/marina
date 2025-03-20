const { Document } = require("../../models/document");
const { Domain } = require("../../models/domain");

/**-----------------------------------------------------------------------------------
  * * GET -> /admin/documents
  Handles the GET request to retrieve a list of documents 
  based on certain criteria
----------------------------------------------------------------------------------**/
exports.getDocuments = async function (req, res) {
  try {
    let docs;
    const page = req.query.page || 1;
    const pageSize = 10; // req.query.pageSize ?

    if (req.query.criteria) {
      let query = {};
      if (req.query.domain) {
        query["domain"] = req.query.domain;
      }
      switch (req.query.criteria) {
        case "new": {
          const daysAgo = new Date();
          daysAgo.setDate(daysAgo.getDate() - 7);
          query["dtCr"] = { $gte: daysAgo };
          break;
        }
        default:
          break;
      }
      docs = await Document.find(query)
        .select("-dtCr -dtUp")
        .populate({
          path: "domainId",
          select: "name",
        })
        .sort({ dtStatus: -1 })
        .skip((page - 1) * pageSize)
        .limit(pageSize);
    } else if (req.query.domain) {
      docs = await Document.find({ domain: req.query.domain })
        .select("-dtCr -dtUp")
        .populate({ path: "domainId", select: "name" })
        .sort({ dtStatus: -1 })
        .skip((page - 1) * pageSize)
        .limit(pageSize);
    } else {
      docs = await Document.find()
        .select("-dtCr -dtUp")
        .populate({ path: "domainId", select: "name" })
        .sort({ dtStatus: -1 })
        .skip((page - 1) * pageSize)
        .limit(pageSize);
    }

    if (!docs) return res.status(404).json({ message: "Documents not found" });
    return res.json(docs);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/**----------------------------------------------------------------------------------
  * * GET -> /admin/documents/:id
  Handles the GET request to fetch a specific document by its ID
----------------------------------------------------------------------------------**/
exports.getDocumentById = async function (req, res) {
  try {
    const document = await Document.findById(req.params.id)
      .select("-dtStatus -dtCri")
      .populate("domainId", "name");
    if (!document)
      return res.status(404).json({ message: "Document not found" });
    return res.json(document);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/**----------------------------------------------------------------------------------
  * * GET -> /admin/documents/count
  Handles the GET request to retrieve the total count of documents in the database
----------------------------------------------------------------------------------**/
exports.getDocumentsCount = async function (req, res) {
  try {
    const docsCount = await Document.countDocuments();
    if (!docsCount)
      return res.status(500).json({ message: "Could not count documents" });
    return res.json(docsCount);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/**----------------------------------------------------------------------------------
  * * GET -> /admin/documents/search
  Handle the GET request to search for documents 
  based on a search term and optional domain criteria.
----------------------------------------------------------------------------------**/
exports.searchDocuments = async function (req, res) {
  try {
    const searchTerm = req.query.q;
    // if (!searchTerm) {} make sense?

    const page = req.query.page || 1;
    const pageSize = 10;

    let query = {};
    if (req.query.domain) {
      query = { domain: req.query.domain };
    }

    if (searchTerm) {
      query = {
        ...query,
        $text: {
          $search: searchTerm,
          $language: "portuguese",
          $caseSensitive: false,
        },
      };
    }

    const searchResults = await Document.find(query)
      .skip((page - 1) * pageSize)
      .limit(pageSize);

    return res.json(searchResults);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/**----------------------------------------------------------------------------------
  * * POST -> /admin/documents
  Handle the POST request to add a new document to the database
----------------------------------------------------------------------------------**/
exports.addDocument = async function (req, res) {
  try {
    const { domainId, title, text, status } = req.body;

    const domain = await Domain.findById(domainId);
    if (!domain) return res.status(404).json({ message: "Domain not found" });

    let document = new Document({
      domainId: domain._id,
      title: title.trim(),
      text: text.trim(),
      status: status.trim(),
    });
    document = await document.save();
    if (!document) {
      return res.status(500).json({ message: "Document could not be created" });
    }

    res.status(201).json(document);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/**----------------------------------------------------------------------------------
  * * PUT -> /admin/documents/:id
  Handle the PUT request to update a specific document in the database
----------------------------------------------------------------------------------**/
exports.editDocument = async function (req, res) {
  try {
    const domain = await Domain.findById(req.body.domainId);
    // Confirm if Domain exists and is active
    if (!domain) return res.status(404).json({ message: "Domain not found" });
    if (domain.status != "active")
      return res.status(406).json({ message: "Domain inactive" });

    const document = await Document.findByIdAndUpdate(
      userId,
      { ...req.body, dtup: Date.now() },
      { new: true, runValidators: true }
    );
    if (!document)
      return res.status(404).json({ message: "Document not found" });

    return res.json(document);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

/**----------------------------------------------------------------------------------
  * * DELETE -> /admin/documents/:id
  Handle the DELETE request to delete a specific document from the database
----------------------------------------------------------------------------------**/
/* The `exports.deleteDocument` function is .
Here's a breakdown of what the function does: */
exports.deleteDocument = async function (req, res) {
  try {
    const document = await Domain.findOneAndDelete({ _id: req.params.id });
    if (!document)
      return res.status(404).json({ message: "Document not found" });

    return res.status(204).end();
  } catch (error) {
    console.error(error);
    return res.status(500).json({ type: error.name, message: error.message });
  }
};
